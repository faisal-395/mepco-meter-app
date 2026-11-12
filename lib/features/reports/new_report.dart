import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../domain/report_templates.dart';
import '../../domain/settings_keys.dart';

/// Default team text for a new report, from settings.
String defaultTeamText(Map<String, String> s) {
  final parts = <String>[
    if ((s[SettingKeys.testInspector] ?? '').isNotEmpty)
      '${s[SettingKeys.testInspector]} Test Inspector M&T',
    if ((s[SettingKeys.ta] ?? '').isNotEmpty) '${s[SettingKeys.ta]} T.A M&T',
  ];
  return parts.join(', ');
}

/// Asks for the report type (and consumer if not given), creates a draft and opens the wizard.
Future<void> startNewReport(
  BuildContext context,
  WidgetRef ref, {
  int? consumerId,
}) async {
  final type = await showDialog<String>(
    context: context,
    builder: (c) => SimpleDialog(
      title: const Text('Report type'),
      children: [
        for (final t in ReportType.all)
          SimpleDialogOption(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            onPressed: () => Navigator.pop(c, t),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  templateFor(t).shortName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  templateFor(t).title,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  if (type == null || !context.mounted) return;
  consumerId ??= await context.push<int>('/consumers/pick');
  if (consumerId == null || !context.mounted) return;
  final settings = await ref.read(settingsDaoProvider).getAll();
  final id = await ref
      .read(reportsDaoProvider)
      .createDraft(
        consumerId: consumerId,
        type: type,
        teamText: defaultTeamText(settings),
      );
  if (context.mounted) context.push('/reports/$id');
}
