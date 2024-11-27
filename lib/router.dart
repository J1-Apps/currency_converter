import "package:currency_converter/ui/favorites/favorites_screen.dart";
import "package:currency_converter/ui/home/home_screen.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:currency_converter/ui/test/test_screen.dart";
import "package:flutter/foundation.dart";
import "package:j1_router/j1_router.dart";

// This is a configuration file that doesn't need to be tested.
// coverage:ignore-file

const _homePath = "/";
const _settingsPath = "settings";
const _favoritesPath = "favorites";
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
            J1RouteNode(
              route: CcRoute.favoritesRoute,
              builder: (_, __) => const FavoritesScreen(),
            ),
            if (kDebugMode)
              J1RouteNode(
                route: CcRoute.testRoute,
                builder: (_, __) => const TestScreen(),
              ),
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

  static const favoritesRoute = J1Route<EmptyRouteConfig>(
    parts: [PathSegment(_homePath), PathSegment(_settingsPath), PathSegment(_favoritesPath)],
    configParser: EmptyRouteConfig.parser,
  );

  static const testRoute = J1Route<EmptyRouteConfig>(
    parts: [PathSegment(_homePath), PathSegment(_settingsPath), PathSegment(_testPath)],
    configParser: EmptyRouteConfig.parser,
  );
}
