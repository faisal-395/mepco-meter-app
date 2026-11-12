import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('MEPCO Meter Reports')),
      ),
    ),
  ],
);
