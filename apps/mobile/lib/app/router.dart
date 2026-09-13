import 'package:go_router/go_router.dart';

import '../gallery/overview_page.dart';

final GoRouter keynestRouter = GoRouter(
  initialLocation: '/overview',
  routes: [
    GoRoute(
      path: '/overview',
      builder: (context, state) => const OverviewPage(),
    ),
  ],
);
