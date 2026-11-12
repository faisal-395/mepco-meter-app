import 'package:material_ui/material_ui.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key, required this.reportId});
  final int reportId;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('Coming soon')));
}
