import 'global.dart';
import 'pages/home.dart';

final router = GoRouter(
  navigatorKey: $el.navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
