import 'package:app_navigation_template/navigation/app_route_information_parser.dart';
import 'package:app_navigation_template/navigation/app_router_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNavigation {
  static AppRouteInformationParser get routeInformationParser =>
      AppRouteInformationParser();

  static AppRouterDelegate routerDelegate({required WidgetRef ref}) {
    return AppRouterDelegate(ref: ref);
  }
}
