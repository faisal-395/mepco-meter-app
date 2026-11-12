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

  /// (short name, letter on the form, full section title)
  static const _steps = [
    ('Header', '', 'Memo & Reference'),
    ('Installation', 'A', 'Description of Installation'),
    ('Meters', 'B', 'Energy Meter Particulars'),
    ('Readings', '', 'Meter Readings'),
    ('Checking', 'C', 'Meter Checking Results'),
    ('Seals', 'D', 'Sealing Status / Record'),
    ('Remarks', 'E', 'Discrepancy, Remarks & Recommendations'),
    ('Signers', 'F', 'Postal Orders Signed By'),
    ('Review', '', 'Review & Finalise'),
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
          final (short, letter, full) = _steps[_step];
          final body = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionBand(
                letter: letter,
                title: full,
                step: _step,
                count: _steps.length,
              ),
              Expanded(child: _stepBody(c)),
            ],
          );
          final nav = _NavBar(
            step: _step,
            count: _steps.length,
            nextLabel: _step == _steps.length - 1 ? null : _steps[_step + 1].$1,
            onBack: _step == 0 ? null : () => _goTo(_step - 1),
            onNext: _step == _steps.length - 1 ? null : () => _goTo(_step + 1),
          );
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 64,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1,
                      color: AppColors.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    c.bundle.sectionA['name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              actions: [
                _SaveState(saving: c.saving, dirty: c.dirty),
                IconButton(
                  tooltip: 'Save',
                  icon: const Icon(Icons.save_outlined),
                  onPressed: c.save,
                ),
                IconButton(
                  tooltip: 'Print / PDF',
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  onPressed: () async {
                    await c.save();
                    if (context.mounted) {
                      context.push('/reports/${widget.reportId}/pdf');
                    }
                  },
                ),
              ],
            ),
            body: wide
                ? Row(
                    children: [
                      Container(
                        width: 240,
                        color: Colors.white,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            for (var i = 0; i < _steps.length; i++)
                              _StepTile(
                                index: i,
                                label: _steps[i].$1,
                                letter: _steps[i].$2,
                                selected: i == _step,
                                done: i < _step,
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

/// Navy-light band naming the current form section, with step progress.
class _SectionBand extends StatelessWidget {
  const _SectionBand({
    required this.letter,
    required this.title,
    required this.step,
    required this.count,
  });
  final String letter;
  final String title;
  final int step;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navyLight,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: letter.isEmpty
                      ? Text(
                          '${step + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      : Text(
                          letter,
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Text(
                  'STEP ${step + 1} OF $count',
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: (step + 1) / count,
            minHeight: 3,
            color: AppColors.gold,
            backgroundColor: AppColors.line,
          ),
        ],
      ),
    );
  }
}

class _SaveState extends StatelessWidget {
  const _SaveState({required this.saving, required this.dirty});
  final bool saving;
  final bool dirty;

  @override
  Widget build(BuildContext context) {
    final (text, icon) = saving
        ? ('Saving', Icons.sync)
        : dirty
        ? ('Unsaved', Icons.edit)
        : ('Saved', Icons.check_circle_outline);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.gold),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.label,
    required this.letter,
    required this.selected,
    required this.done,
    required this.onTap,
  });
  final int index;
  final String label;
  final String letter;
  final bool selected;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.navyLight : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: selected ? AppColors.gold : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: selected || done
                    ? AppColors.navy
                    : AppColors.line,
                child: done
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : Text(
                        letter.isEmpty ? '${index + 1}' : letter,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: selected ? AppColors.gold : AppColors.navy,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                  color: selected ? AppColors.navy : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.step,
    required this.count,
    required this.nextLabel,
    required this.onBack,
    required this.onNext,
  });
  final int step;
  final int count;
  final String? nextLabel;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: FilledButton(
                  onPressed: onNext,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Next'),
                      if (nextLabel != null)
                        Flexible(
                          child: Text(
                            ': $nextLabel',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
