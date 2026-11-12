import 'package:material_ui/material_ui.dart';

class ConsumerHistoryScreen extends StatelessWidget {
  const ConsumerHistoryScreen({super.key, required this.consumerId});
  final int consumerId;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('Coming soon')));
}
