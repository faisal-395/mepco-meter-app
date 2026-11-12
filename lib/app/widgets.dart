import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../domain/formatters.dart';
import 'theme.dart';

/// A text field bound to a value, with a numeric keyboard when [numeric].
class AppField extends StatefulWidget {
  const AppField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.numeric = false,
    this.maxLines = 1,
    this.helper,
    this.enabled = true,
    this.hint,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool numeric;
  final int maxLines;
  final String? helper;
  final String? hint;
  final bool enabled;

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  late final TextEditingController _c = TextEditingController(
    text: widget.value,
  );

  @override
  void didUpdateWidget(AppField old) {
    super.didUpdateWidget(old);
    // Keep the field in sync when the value is changed from outside.
    if (widget.value != _c.text) {
      _c.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: _c,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        minLines: 1,
        keyboardType: widget.numeric
            ? const TextInputType.numberWithOptions(decimal: true, signed: true)
            : (widget.maxLines > 1
                  ? TextInputType.multiline
                  : TextInputType.text),
        inputFormatters: widget.numeric
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'))]
            : null,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
          labelText: widget.label,
          helperText: widget.helper,
          hintText: widget.hint,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

/// A date field (dd-MM-yy) with a calendar button.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: !enabled
            ? null
            : () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: value ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) onChanged(picked);
              },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            enabled: enabled,
            suffixIcon: value != null && enabled
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: 'Clear',
                    onPressed: () => onChanged(null),
                  )
                : const Icon(Icons.calendar_today),
          ),
          child: Text(fmtDate(value), style: const TextStyle(fontSize: 17)),
        ),
      ),
    );
  }
}

/// A date field for a text value stored as dd-MM-yy.
class TextDateField extends StatelessWidget {
  const TextDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => DateField(
    label: label,
    value: parseDate(value),
    onChanged: (d) => onChanged(fmtDate(d)),
  );
}

/// Lays children out in two columns on wide screens, one column on phones.
class ResponsiveFields extends StatelessWidget {
  const ResponsiveFields({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }
        final w = (c.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          children: [for (final ch in children) SizedBox(width: w, child: ch)],
        );
      },
    );
  }
}

/// Small uppercase heading with a gold bar, like a heading on an office form.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 8),
    child: Row(
      children: [
        Container(width: 4, height: 18, color: AppColors.gold),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.navy,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Navy band with the office name, shown at the top of the home screen.
class OfficeHeader extends StatelessWidget {
  const OfficeHeader({super.key, required this.circle, this.trailing});
  final String circle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.navy,
        border: Border(bottom: BorderSide(color: AppColors.gold, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: const Icon(Icons.bolt, color: AppColors.navy, size: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MULTAN ELECTRIC POWER COMPANY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Office of the Executive Engineer M&T',
                  style: TextStyle(color: Color(0xFFDCE4EF), fontSize: 13),
                ),
                Text(
                  'Circle $circle',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// A form section panel: navy title band (with a letter badge) over white content.
class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.title,
    required this.child,
    this.letter,
    this.action,
  });
  final String? letter;
  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.navyLight,
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            child: Row(
              children: [
                if (letter != null) ...[
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      letter!,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                ?action,
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(12), child: child),
        ],
      ),
    );
  }
}

/// Bordered two-column key/value table (like the cells of a paper form).
class InfoTable extends StatelessWidget {
  const InfoTable(this.rows, {super.key, this.labelWidth = 140});
  final List<(String, String)> rows;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    final visible = rows.where((r) => r.$2.trim().isNotEmpty).toList();
    if (visible.isEmpty) return const SizedBox.shrink();
    return Table(
      border: TableBorder.all(color: AppColors.line),
      columnWidths: {0: FixedColumnWidth(labelWidth)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        for (final r in visible)
          TableRow(
            children: [
              Container(
                color: AppColors.paper,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 9,
                ),
                child: Text(
                  r.$1,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 9,
                ),
                child: Text(
                  r.$2,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Small coloured status label (DRAFT / FINAL).
class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});
  final String status;

  @override
  Widget build(BuildContext context) {
    final isFinal = status == 'final' || status == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isFinal ? const Color(0xFFE3F1E6) : AppColors.goldLight,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: isFinal ? okColor : AppColors.gold),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: isFinal ? okColor : const Color(0xFF7A5C00),
        ),
      ),
    );
  }
}

/// Yellow banner listing warnings. Warnings never block saving.
class WarningBanner extends StatelessWidget {
  const WarningBanner(this.warnings, {super.key});
  final List<String> warnings;

  @override
  Widget build(BuildContext context) {
    if (warnings.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warningColor,
        border: Border.all(color: warningBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final w in warnings)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber,
                    size: 20,
                    color: Colors.brown,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(w)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Future<bool> confirm(
  BuildContext context,
  String title,
  String message, {
  String ok = 'Yes',
  String cancel = 'No',
}) async {
  final r = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c, false),
          child: Text(cancel),
        ),
        FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(ok)),
      ],
    ),
  );
  return r ?? false;
}

void showSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

/// Shows an AsyncValue's error or a spinner.
Widget loadingOrError(Object? error) => Center(
  child: error == null
      ? const CircularProgressIndicator()
      : Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error: $error'),
        ),
);

/// Small input for tables (no label). Shows [hint] in grey when empty.
class CompactField extends StatefulWidget {
  const CompactField({
    super.key,
    required this.value,
    required this.onChanged,
    this.hint,
    this.numeric = true,
    this.textAlign = TextAlign.center,
  });
  final String value;
  final ValueChanged<String> onChanged;
  final String? hint;
  final bool numeric;
  final TextAlign textAlign;

  @override
  State<CompactField> createState() => _CompactFieldState();
}

class _CompactFieldState extends State<CompactField> {
  late final _c = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(CompactField old) {
    super.didUpdateWidget(old);
    if (widget.value != _c.text) _c.text = widget.value;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _c,
      textAlign: widget.textAlign,
      style: const TextStyle(fontSize: 15.5),
      keyboardType: widget.numeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: widget.numeric
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]'))]
          : null,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: AppColors.muted),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      ),
      onChanged: widget.onChanged,
    );
  }
}
