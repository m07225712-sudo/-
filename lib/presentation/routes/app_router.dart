import 'package:auto_route/auto_route.dart';

import '../../screens/main_navigation_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainNavigationRoute.page, initial: true),
      ];
}
