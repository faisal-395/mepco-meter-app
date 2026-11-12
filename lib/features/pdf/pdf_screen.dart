import 'package:material_ui/material_ui.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key, required this.reportId, this.finalView = false});
  final int reportId;
  final bool finalView;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('PDF')));
}
