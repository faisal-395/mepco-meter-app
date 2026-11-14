import 'package:material_ui/material_ui.dart';

import 'theme.dart';

/// Which field should be shown next (set when a warning is tapped).
class FieldFocus extends ChangeNotifier {
  String? target;
  int _seq = 0;
  int get seq => _seq;

  void go(String id) {
    target = id;
    _seq++;
    notifyListeners();
  }

  /// Marks the request as handled (no rebuild).
  void done() => target = null;
}

/// Makes a [FieldFocus] available to the [FieldAnchor]s below it.
class FieldFocusScope extends InheritedNotifier<FieldFocus> {
  const FieldFocusScope({
    super.key,
    required FieldFocus super.notifier,
    required super.child,
  });

  static FieldFocus? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FieldFocusScope>()?.notifier;
}

/// Wraps a field. When its [id] is requested: scrolls it into view, puts the
/// cursor in it (if it is a text field) and flashes a yellow frame around it.
class FieldAnchor extends StatefulWidget {
  const FieldAnchor({super.key, required this.id, required this.child});
  final String id;
  final Widget child;

  @override
  State<FieldAnchor> createState() => _FieldAnchorState();
}

class _FieldAnchorState extends State<FieldAnchor> {
  int _handled = -1;
  bool _flash = false;

  void _show() {
    if (!mounted) return;
    Scrollable.ensureVisible(
      context,
      alignment: 0.2,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
    // Focus the first text field inside this anchor.
    var focused = false;
    void visit(Element e) {
      if (focused) return;
      final w = e.widget;
      if (w is EditableText) {
        w.focusNode.requestFocus();
        focused = true;
        return;
      }
      e.visitChildren(visit);
    }

    (context as Element).visitChildren(visit);
    setState(() => _flash = true);
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _flash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final f = FieldFocusScope.of(context);
    if (f != null && f.target == widget.id && _handled != f.seq) {
      _handled = f.seq;
      f.done();
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 60), _show),
      );
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _flash ? warningBorder : Colors.transparent,
          width: 2.5,
        ),
        color: _flash ? warningColor : Colors.transparent,
      ),
      child: widget.child,
    );
  }
}
