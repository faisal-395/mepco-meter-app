import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../domain/settings_keys.dart';
import 'backup_section.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Map<String, String>? _values;
  List<String> _cc = [];

  @override
  void initState() {
    super.initState();
    ref.read(settingsDaoProvider).getAll().then((v) {
      if (!mounted) return;
      setState(() {
        _values = Map.of(v);
        _cc = (v[SettingKeys.ccList] ?? '')
            .split('\n')
            .where((l) => l.trim().isNotEmpty)
            .toList();
      });
    });
  }

  Future<void> _save() async {
    final dao = ref.read(settingsDaoProvider);
    final v = _values!;
    v[SettingKeys.ccList] = _cc
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .join('\n');
    for (final k in [
      ...SettingKeys.labels.keys,
      SettingKeys.checkLoadMethod,
      SettingKeys.ccList,
    ]) {
      await dao.set(k, v[k] ?? '');
    }
    if (mounted) showSnack(context, 'Settings saved');
  }

  @override
  Widget build(BuildContext context) {
    final v = _values;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          TextButton.icon(
            style: appBarButtonStyle,
            onPressed: v == null ? null : _save,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
      body: v == null
          ? loadingOrError(null)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionTitle('Office and officers'),
                ResponsiveFields(
                  children: [
                    for (final e in SettingKeys.labels.entries)
                      AppField(
                        label: e.value,
                        value: v[e.key] ?? '',
                        numeric: e.key == SettingKeys.permissibleErrorLimit,
                        helper: e.key == SettingKeys.permissibleErrorLimit
                            ? 'Empty = no automatic within-limit check'
                            : null,
                        onChanged: (x) => v[e.key] = x,
                      ),
                  ],
                ),
                const SectionTitle('Check load method'),
                RadioGroup<String>(
                  groupValue: v[SettingKeys.checkLoadMethod],
                  onChanged: (x) =>
                      setState(() => v[SettingKeys.checkLoadMethod] = x!),
                  child: const Column(
                    children: [
                      RadioListTile(
                        value: SettingKeys.methodAverage,
                        title: Text('Average of the three phases'),
                      ),
                      RadioListTile(
                        value: SettingKeys.methodSum,
                        title: Text('Sum of the three phases'),
                      ),
                    ],
                  ),
                ),
                const SectionTitle('C.C list (printed on page 2)'),
                const Text(
                  'Use {division} for the consumer\'s OP division.',
                  style: TextStyle(color: Colors.black54),
                ),
                for (var i = 0; i < _cc.length; i++)
                  Row(
                    key: ObjectKey(_cc[i].hashCode ^ i),
                    children: [
                      SizedBox(width: 28, child: Text('${i + 1}.')),
                      Expanded(
                        child: AppField(
                          label: 'Line ${i + 1}',
                          value: _cc[i],
                          maxLines: 3,
                          onChanged: (x) => _cc[i] = x,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove line',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => setState(() => _cc.removeAt(i)),
                      ),
                    ],
                  ),
                Wrap(
                  spacing: 8,
                  children: [
                    TextButton.icon(
                      onPressed: () => setState(() => _cc.add('')),
                      icon: const Icon(Icons.add),
                      label: const Text('Add line'),
                    ),
                    TextButton.icon(
                      onPressed: () => setState(
                        () => _cc = List.of(SettingKeys.defaultCcList),
                      ),
                      icon: const Icon(Icons.restore),
                      label: const Text('Reset to default'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save settings'),
                ),
                const Divider(height: 40),
                const BackupSection(),
              ],
            ),
    );
  }
}
