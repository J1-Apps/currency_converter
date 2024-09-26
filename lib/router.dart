import "package:currency_converter/ui/home/home_screen.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:currency_converter/ui/test/test_screen.dart";
import "package:flutter/foundation.dart";
import "package:j1_router/j1_router.dart";

const _homePath = "/";
const _settingsPath = "settings";
const _testPath = "test";

final routeGraph = GoRouteGraph(
  routes: [
    J1RouteNode(
      route: CcRoute.homeRoute,
      builder: (_, __) => const HomeScreen(),
      routes: [
        J1RouteNode(
          route: CcRoute.settingsRoute,
          builder: (_, __) => const SettingsScreen(),
          routes: [
            // coverage:ignore-start
            if (kDebugMode)
              J1RouteNode(
                route: CcRoute.testRoute,
                builder: (_, __) => const TestScreen(),
              ),
            // coverage:ignore-end
          ],
        ),
      ],
    )
  ],
);

abstract class CcRoute {
  static const homeRoute = J1Route<EmptyRouteConfig>(
    parts: [PathSegment(_homePath)],
    configParser: EmptyRouteConfig.parser,
  );

  static const settingsRoute = J1Route<EmptyRouteConfig>(
    parts: [PathSegment(_homePath), PathSegment(_settingsPath)],
    configParser: EmptyRouteConfig.parser,
  );

  static const testRoute = J1Route<EmptyRouteConfig>(
    parts: [PathSegment(_homePath), PathSegment(_settingsPath), PathSegment(_testPath)],
    configParser: EmptyRouteConfig.parser,
  );
}
