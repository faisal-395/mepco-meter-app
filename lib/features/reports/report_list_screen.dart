import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/daos.dart';
import '../../domain/formatters.dart';
import '../../domain/report_templates.dart';

class _Filter {
  const _Filter({
    this.from,
    this.to,
    this.subDivision = '',
    this.type,
    this.query = '',
  });
  final DateTime? from;
  final DateTime? to;
  final String subDivision;
  final String? type;
  final String query;

  @override
  bool operator ==(Object o) =>
      o is _Filter &&
      o.from == from &&
      o.to == to &&
      o.subDivision == subDivision &&
      o.type == type &&
      o.query == query;

  @override
  int get hashCode => Object.hash(from, to, subDivision, type, query);
}

final _reportsProvider = StreamProvider.autoDispose
    .family<List<ReportListItem>, _Filter>(
      (ref, f) => ref
          .watch(reportsDaoProvider)
          .watchFiltered(
            from: f.from,
            to: f.to,
            subDivision: f.subDivision,
            type: f.type,
            query: f.query,
          ),
    );

/// Report list / memo register with filters by date, sub division and type.
class ReportListScreen extends ConsumerStatefulWidget {
  const ReportListScreen({super.key});

  @override
  ConsumerState<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends ConsumerState<ReportListScreen> {
  _Filter _f = const _Filter();

  void _set({
    DateTime? from,
    DateTime? to,
    String? sub,
    String? type,
    String? q,
    bool clearFrom = false,
    bool clearTo = false,
    bool clearType = false,
  }) {
    setState(
      () => _f = _Filter(
        from: clearFrom ? null : (from ?? _f.from),
        to: clearTo ? null : (to ?? _f.to),
        subDivision: sub ?? _f.subDivision,
        type: clearType ? null : (type ?? _f.type),
        query: q ?? _f.query,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(_reportsProvider(_f));
    final wide = isWide(context);
    final filters = Wrap(
      spacing: 12,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: wide ? 200 : double.infinity,
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Memo No / name / A/C',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (v) => _set(q: v),
          ),
        ),
        SizedBox(
          width: wide ? 180 : double.infinity,
          child: TextField(
            decoration: const InputDecoration(labelText: 'Sub division'),
            onChanged: (v) => _set(sub: v),
          ),
        ),
        SizedBox(
          width: 160,
          child: DateField(
            label: 'From',
            value: _f.from,
            onChanged: (d) => d == null ? _set(clearFrom: true) : _set(from: d),
          ),
        ),
        SizedBox(
          width: 160,
          child: DateField(
            label: 'To',
            value: _f.to,
            onChanged: (d) => d == null ? _set(clearTo: true) : _set(to: d),
          ),
        ),
        DropdownButton<String?>(
          value: _f.type,
          hint: const Text('All types'),
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('All types'),
            ),
            for (final t in ReportType.all)
              DropdownMenuItem<String?>(
                value: t,
                child: Text(templateFor(t).shortName),
              ),
          ],
          onChanged: (v) => v == null ? _set(clearType: true) : _set(type: v),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Reports / memo register')),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12), child: filters),
          const Divider(height: 1),
          Expanded(
            child: list.when(
              loading: () => loadingOrError(null),
              error: (e, _) => loadingOrError(e),
              data: (items) => items.isEmpty
                  ? const Center(child: Text('No reports'))
                  : wide
                  ? SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showCheckboxColumn: false,
                          columns: const [
                            DataColumn(label: Text('Memo No')),
                            DataColumn(label: Text('Memo date')),
                            DataColumn(label: Text('Visit')),
                            DataColumn(label: Text('Type')),
                            DataColumn(label: Text('Consumer')),
                            DataColumn(label: Text('A/C No')),
                            DataColumn(label: Text('Sub division')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: [
                            for (final it in items)
                              DataRow(
                                onSelectChanged: (_) =>
                                    context.push('/reports/${it.report.id}'),
                                cells: [
                                  DataCell(Text(it.report.memoNo)),
                                  DataCell(Text(fmtDate(it.report.memoDate))),
                                  DataCell(Text(fmtDate(it.report.visitDate))),
                                  DataCell(
                                    Text(
                                      templateFor(it.report.reportType)
                                          .shortName,
                                    ),
                                  ),
                                  DataCell(Text(it.consumer.name)),
                                  DataCell(Text(it.consumer.accountNo)),
                                  DataCell(Text(it.report.toSubDivision)),
                                  DataCell(Text(it.report.status)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final it = items[i];
                        return ListTile(
                          leading: Icon(
                            it.report.status == 'final'
                                ? Icons.verified
                                : Icons.edit_note,
                          ),
                          title: Text(
                            'Memo ${it.report.memoNo.isEmpty ? '-' : it.report.memoNo}  •  ${it.consumer.name}',
                          ),
                          subtitle: Text(
                            '${templateFor(it.report.reportType).shortName}  •  ${fmtDate(it.report.visitDate)}  •  ${it.report.toSubDivision}',
                          ),
                          onTap: () => context.push('/reports/${it.report.id}'),
                        );
                      },
                    ),
            ),
          ),
          list.maybeWhen(
            data: (items) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${items.length} report(s)'),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
