import "package:currency_converter/ui/screen/home_screen.dart";
import "package:j1_router/j1_router.dart";

const _homePath = "/";

final routeGraph = GoRouteGraph(
  routes: [
    J1RouteNode(
      route: homeRoute,
      builder: (_, __) => const HomeScreen(),
    )
  ],
);

const homeRoute = J1Route<EmptyRouteConfig>(
  parts: [PathSegment(_homePath)],
  configParser: EmptyRouteConfig.parser,
);
