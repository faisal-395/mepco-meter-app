import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/daos.dart';
import '../../data/database.dart';
import '../../domain/calculations.dart';
import '../../domain/formatters.dart';
import '../../domain/report_templates.dart';

class _MeterHistory {
  _MeterHistory(this.meter, this.visits);
  final Meter meter;
  final List<MeterVisit> visits;
}

final _historyProvider = FutureProvider.autoDispose
    .family<List<_MeterHistory>, int>((ref, id) async {
      final meters = await ref.watch(metersDaoProvider).forConsumer(id);
      final dao = ref.watch(reportsDaoProvider);
      return [
        for (final m in meters) _MeterHistory(m, await dao.meterHistory(m.id)),
      ];
    });

/// Readings of every meter across all visits, with consumption between visits (x MF).
class ConsumerHistoryScreen extends ConsumerWidget {
  const ConsumerHistoryScreen({super.key, required this.consumerId});
  final int consumerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumer = ref.watch(consumerProvider(consumerId)).value;
    final hist = ref.watch(_historyProvider(consumerId));
    return Scaffold(
      appBar: AppBar(title: Text('History — ${consumer?.name ?? ''}')),
      body: hist.when(
        loading: () => loadingOrError(null),
        error: (e, _) => loadingOrError(e),
        data: (list) => list.isEmpty
            ? const Center(child: Text('No meters'))
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final h in list) ...[
                    SectionTitle(
                      'Meter ${h.meter.mfgNo}  ${h.meter.make} ${h.meter.meterKind}'
                      '${h.meter.status == 'removed' ? '  (removed)' : ''}',
                    ),
                    if (h.visits.isEmpty)
                      const Text('No readings yet.')
                    else
                      _HistoryTable(
                        meter: h.meter,
                        visits: h.visits,
                        consumerMf: consumer?.mf,
                      ),
                  ],
                ],
              ),
      ),
    );
  }
}

class _HistoryTable extends StatelessWidget {
  const _HistoryTable({
    required this.meter,
    required this.visits,
    this.consumerMf,
  });
  final Meter meter;
  final List<MeterVisit> visits;
  final String? consumerMf;

  @override
  Widget build(BuildContext context) {
    final t = templateFor(visits.last.report.reportType);
    final mf = parseMf(meter.mf) ?? parseMf(consumerMf);
    final codes = [
      ...t.consumptionCodes,
      if (t.isNet) ...[
        'imp_kvarh_total',
        'imp_mdi_total',
        'resets_no',
      ] else ...[
        'mdi_total',
        'cum_mdi_total',
        'reset_no',
      ],
      t.importInstantCode,
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        columns: [
          const DataColumn(label: Text('Visit')),
          const DataColumn(label: Text('Report')),
          for (final c in codes) DataColumn(label: Text(_label(t, c))),
          for (final c in t.consumptionCodes)
            DataColumn(
              label: Text('Used ${_short(c)}\n(x MF ${fmtCompact(mf)})'),
            ),
        ],
        rows: [
          for (var i = 0; i < visits.length; i++)
            DataRow(
              onSelectChanged: (_) =>
                  context.push('/reports/${visits[i].report.id}'),
              cells: [
                DataCell(Text(fmtDate(visits[i].report.visitDate))),
                DataCell(
                  Text(
                    '${templateFor(visits[i].report.reportType).shortName}\n${visits[i].report.memoNo}',
                  ),
                ),
                for (final c in codes)
                  DataCell(
                    Text(
                      c == t.importInstantCode
                          ? instantKwText(visits[i].values[c], mf)
                          : visits[i].values[c] ?? '',
                    ),
                  ),
                for (final c in t.consumptionCodes)
                  DataCell(
                    Text(
                      i == 0
                          ? '—'
                          : fmtNum(
                              consumption(
                                visits[i].values[c],
                                visits[i - 1].values[c],
                                mf,
                              ),
                            ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  String _label(ReportTemplate t, String code) {
    final p = t.params.where((p) => p.code == code).firstOrNull;
    if (p == null) return code;
    if (p.label == 'Peak' || p.label == 'Off Peak') return code;
    return p.label;
  }

  String _short(String code) => switch (code) {
    'kwh_total' => 'KWH',
    'kvarh_total' => 'KVARH',
    'imp_kwh_total' => 'Import KWH',
    'exp_kwh_total' => 'Export KWH',
    _ => code,
  };
}
