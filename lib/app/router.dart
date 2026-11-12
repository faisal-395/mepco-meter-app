import 'package:go_router/go_router.dart';

import '../features/consumers/consumer_detail_screen.dart';
import '../features/consumers/consumer_form_screen.dart';
import '../features/consumers/consumer_list_screen.dart';
import '../features/home/home_screen.dart';
import '../features/meters/meter_form_screen.dart';
import '../features/reports/report_list_screen.dart';
import '../features/reports/report_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/search/search_screen.dart';
import '../features/consumers/consumer_history_screen.dart';

int _id(GoRouterState s, [String name = 'id']) =>
    int.parse(s.pathParameters[name]!);

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (c, s) => const HomeScreen()),
    GoRoute(path: '/consumers', builder: (c, s) => const ConsumerListScreen()),
    GoRoute(
        path: '/consumers/pick',
        builder: (c, s) => const ConsumerListScreen(pickMode: true)),
    GoRoute(
        path: '/consumers/new', builder: (c, s) => const ConsumerFormScreen()),
    GoRoute(
        path: '/consumers/:id',
        builder: (c, s) => ConsumerDetailScreen(consumerId: _id(s))),
    GoRoute(
        path: '/consumers/:id/edit',
        builder: (c, s) => ConsumerFormScreen(consumerId: _id(s))),
    GoRoute(
        path: '/consumers/:id/history',
        builder: (c, s) => ConsumerHistoryScreen(consumerId: _id(s))),
    GoRoute(
        path: '/consumers/:id/meters/new',
        builder: (c, s) => MeterFormScreen(
            consumerId: _id(s), defaultKind: s.uri.queryParameters['kind'])),
    GoRoute(
        path: '/meters/:id/edit',
        builder: (c, s) => MeterFormScreen(meterId: _id(s))),
    GoRoute(path: '/reports', builder: (c, s) => const ReportListScreen()),
    GoRoute(
        path: '/reports/:id',
        builder: (c, s) => ReportScreen(reportId: _id(s))),
    GoRoute(path: '/search', builder: (c, s) => const SearchScreen()),
    GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
  ],
);
