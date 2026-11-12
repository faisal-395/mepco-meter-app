import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/daos.dart';
import '../../domain/formatters.dart';
import '../../domain/report_templates.dart';

final _searchProvider = FutureProvider.autoDispose
    .family<SearchResults, String>(
      (ref, q) => ref.watch(reportsDaoProvider).search(q),
    );

/// Search by account no, name, meter no or memo no.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(_searchProvider(_q));
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'A/C No, name, meter No or memo No',
              ),
              onChanged: (v) => setState(() => _q = v.trim()),
            ),
          ),
          Expanded(
            child: _q.isEmpty
                ? const Center(child: Text('Type to search'))
                : res.when(
                    loading: () => loadingOrError(null),
                    error: (e, _) => loadingOrError(e),
                    data: (r) => r.isEmpty
                        ? const Center(child: Text('Nothing found'))
                        : ListView(
                            children: [
                              if (r.consumers.isNotEmpty)
                                const _Head('Consumers'),
                              for (final c in r.consumers)
                                ListTile(
                                  leading: const Icon(Icons.person),
                                  title: Text(c.name),
                                  subtitle: Text(
                                    '${c.accountNo}  ${c.subDivision}',
                                  ),
                                  onTap: () =>
                                      context.push('/consumers/${c.id}'),
                                ),
                              if (r.meters.isNotEmpty) const _Head('Meters'),
                              for (final (m, c) in r.meters)
                                ListTile(
                                  leading: const Icon(Icons.electric_meter),
                                  title: Text(
                                    '${m.mfgNo}  ${m.make} ${m.meterKind}',
                                  ),
                                  subtitle: Text(
                                    '${c.name}  •  ${c.accountNo}'
                                    '${m.status == 'removed' ? '  •  removed' : ''}',
                                  ),
                                  onTap: () =>
                                      context.push('/consumers/${c.id}'),
                                ),
                              if (r.reports.isNotEmpty)
                                const _Head('Reports (memo No)'),
                              for (final it in r.reports)
                                ListTile(
                                  leading: const Icon(Icons.description),
                                  title: Text(
                                    'Memo ${it.report.memoNo}  •  ${fmtDate(it.report.memoDate)}',
                                  ),
                                  subtitle: Text(
                                    '${templateFor(it.report.reportType).shortName}  •  ${it.consumer.name}',
                                  ),
                                  onTap: () =>
                                      context.push('/reports/${it.report.id}'),
                                ),
                            ],
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Head extends StatelessWidget {
  const _Head(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
