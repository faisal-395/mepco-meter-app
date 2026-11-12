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

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 6),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    ),
  );
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
