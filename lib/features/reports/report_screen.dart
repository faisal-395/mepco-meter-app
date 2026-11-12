import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../domain/report_templates.dart';
import '../../domain/section_a.dart';
import '../pdf/pdf_screen.dart';
import 'readings_step.dart';
import 'steps_header.dart';
import 'steps_sections.dart';
import 'wizard_controller.dart';

/// Opens a report: the wizard for a draft, the PDF view for a final report.
class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key, required this.reportId});
  final int reportId;

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen>
    with WidgetsBindingObserver {
  WizardController? _c;
  Object? _error;
  int _step = 0;

  static const _steps = [
    'Header',
    'A) Installation',
    'B) Meters',
    'Readings',
    'C) Checking',
    'D) Seals',
    'E) Remarks',
    'F) Signers',
    'Review',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  Future<void> _load() async {
    try {
      final c = await WizardController.load(
        reportsDao: ref.read(reportsDaoProvider),
        metersDao: ref.read(metersDaoProvider),
        consumersDao: ref.read(consumersDaoProvider),
        settingsDao: ref.read(settingsDaoProvider),
        reportId: widget.reportId,
      );
      if (!mounted) return;
      setState(() {
        _c = c;
        if (c == null) _error = 'Report not found';
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _c?.save();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _c?.save();
    _c?.dispose();
    super.dispose();
  }

  Future<void> _goTo(int step) async {
    final c = _c!;
    if (_step == 1 && step != 1) await _askUpdateConsumer();
    if (_step == 0 && step != 0) await c.reloadPrevious();
    await c.save();
    if (mounted) setState(() => _step = step);
  }

  /// After editing section A: offer to copy the changes to the consumer record.
  Future<void> _askUpdateConsumer() async {
    final c = _c!;
    final b = c.bundle;
    final current = sectionAFromConsumer(b.consumer);
    final changed = sectionAFields
        .where((f) => (b.sectionA[f.code] ?? '') != (current[f.code] ?? ''))
        .toList();
    if (changed.isEmpty) return;
    final ok = await confirm(
      context,
      'Also update consumer record?',
      'You changed: ${changed.map((f) => f.label).join(', ')}.\n\n'
          'Copy these changes to the consumer record too? '
          '(This report keeps its own copy either way.)',
    );
    if (!ok) return;
    final acc = (b.sectionA['account_no'] ?? '').trim();
    final other = await c.consumersDao.findByAccount(acc);
    if (other != null && other.id != b.consumer.id) {
      if (mounted) {
        showSnack(
          context,
          'A/C No $acc belongs to another consumer; not updated.',
        );
      }
      return;
    }
    await c.consumersDao.updateFields(
      b.consumer.id,
      consumerCompanionFromSectionA(b.sectionA),
    );
    b.consumer = (await c.consumersDao.getById(b.consumer.id))!;
    if (mounted) showSnack(context, 'Consumer record updated');
  }

  Widget _stepBody(WizardController c) => switch (_step) {
    0 => HeaderStep(c: c),
    1 => SectionAStep(c: c),
    2 => SectionBStep(c: c),
    3 => ReadingsStep(c: c),
    4 => SectionCStep(c: c),
    5 => SectionDStep(c: c),
    6 => SectionEStep(c: c),
    7 => SectionFStep(c: c),
    _ => ReviewStep(c: c, onGoTo: _goTo),
  };

  @override
  Widget build(BuildContext context) {
    final c = _c;
    if (c == null) {
      return Scaffold(appBar: AppBar(), body: loadingOrError(_error));
    }
    if (c.bundle.isFinal) {
      return PdfScreen(reportId: widget.reportId, finalView: true);
    }
    final wide = isWide(context);
    final title = templateFor(c.bundle.report.reportType).shortName;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) c.save();
      },
      child: ListenableBuilder(
        listenable: c,
        builder: (context, _) {
          final body = _stepBody(c);
          final nav = _NavBar(
            step: _step,
            count: _steps.length,
            onBack: _step == 0 ? null : () => _goTo(_step - 1),
            onNext: _step == _steps.length - 1 ? null : () => _goTo(_step + 1),
          );
          return Scaffold(
            appBar: AppBar(
              title: Text(
                wide
                    ? '$title — ${c.bundle.sectionA['name'] ?? ''}'
                    : _steps[_step],
              ),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      c.saving ? 'Saving…' : (c.dirty ? 'Not saved' : 'Saved'),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Save',
                  icon: const Icon(Icons.save),
                  onPressed: c.save,
                ),
                IconButton(
                  tooltip: 'Print / PDF',
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: () async {
                    await c.save();
                    if (context.mounted) {
                      context.push('/reports/${widget.reportId}/pdf');
                    }
                  },
                ),
              ],
              bottom: wide
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(4),
                      child: LinearProgressIndicator(
                        value: (_step + 1) / _steps.length,
                      ),
                    ),
            ),
            body: wide
                ? Row(
                    children: [
                      SizedBox(
                        width: 220,
                        child: ListView(
                          children: [
                            for (var i = 0; i < _steps.length; i++)
                              ListTile(
                                selected: i == _step,
                                leading: CircleAvatar(
                                  radius: 14,
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                title: Text(_steps[i]),
                                onTap: () => _goTo(i),
                              ),
                          ],
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: body),
                    ],
                  )
                : body,
            bottomNavigationBar: nav,
          );
        },
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.step,
    required this.count,
    required this.onBack,
    required this.onNext,
  });
  final int step;
  final int count;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('${step + 1} / $count'),
            ),
            Expanded(
              child: FilledButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
