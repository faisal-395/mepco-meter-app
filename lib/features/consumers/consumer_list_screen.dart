import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'consumer_detail_screen.dart';

final _consumerSearchProvider = StreamProvider.autoDispose
    .family<List<ConsumerRow>, String>(
      (ref, q) => ref.watch(consumersDaoProvider).watchAll(query: q),
    );

/// Consumer list with search. On a tablet the detail opens in the right pane.
class ConsumerListScreen extends ConsumerStatefulWidget {
  const ConsumerListScreen({super.key, this.pickMode = false});

  /// When true, tapping a consumer returns its id (used by the report wizard).
  final bool pickMode;

  @override
  ConsumerState<ConsumerListScreen> createState() => _ConsumerListScreenState();
}

class _ConsumerListScreenState extends ConsumerState<ConsumerListScreen> {
  String _query = '';
  int? _selected;

  Future<void> _add() async {
    final id = await context.push<int>('/consumers/new');
    if (id == null || !mounted) return;
    if (widget.pickMode) {
      context.pop(id);
    } else if (isWide(context)) {
      setState(() => _selected = id);
    } else {
      context.push('/consumers/$id');
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context) && !widget.pickMode;
    final list = ref.watch(_consumerSearchProvider(_query));
    final listPane = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            autofocus: widget.pickMode,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Search by A/C No or name',
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: list.when(
            loading: () => loadingOrError(null),
            error: (e, _) => loadingOrError(e),
            data: (items) => items.isEmpty
                ? const Center(child: Text('No consumers yet. Tap + to add.'))
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final c = items[i];
                      return ListTile(
                        selected: wide && c.id == _selected,
                        title: Text(c.name.isEmpty ? '(no name)' : c.name),
                        subtitle: Text(
                          '${c.accountNo}  ${c.tariff}  ${c.subDivision}',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          if (widget.pickMode) {
                            context.pop(c.id);
                          } else if (wide) {
                            setState(() => _selected = c.id);
                          } else {
                            context.push('/consumers/${c.id}');
                          }
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pickMode ? 'Pick consumer' : 'Consumers'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.person_add),
        label: const Text('New consumer'),
      ),
      body: wide
          ? Row(
              children: [
                SizedBox(width: 380, child: listPane),
                const VerticalDivider(width: 1),
                Expanded(
                  child: _selected == null
                      ? const Center(child: Text('Select a consumer'))
                      : ConsumerDetailBody(
                          key: ValueKey(_selected),
                          consumerId: _selected!,
                        ),
                ),
              ],
            )
          : listPane,
    );
  }
}
