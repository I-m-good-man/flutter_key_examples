import 'app_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRouteConfig {
  final List<AppPath> pageConfig;

  const AppRouteConfig({required this.pageConfig});

  factory AppRouteConfig.initialPageConfig() {
    final List<AppPath> pageConfig = [LaunchPath()];
    return AppRouteConfig(pageConfig: pageConfig);
  }

  AppRouteConfig copyWith({
    List<AppPath>? pageConfig,
  }) {
    return AppRouteConfig(
      pageConfig: pageConfig ?? this.pageConfig,
    );
  }
}

class AppRouteConfigStateNotifier extends StateNotifier<AppRouteConfig> {
  AppRouteConfigStateNotifier(super.state);

  void setNewState({required AppRouteConfig newState}) {
    state = newState;
  }

  void pushPath({required AppPath appPath}) {
    state = state.copyWith(pageConfig: state.pageConfig..add(appPath));
  }

  void popPath() {
    state = state.copyWith(pageConfig: state.pageConfig..removeLast());
  }
}

typedef NavigationProvider
    = StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>;

final NavigationProvider navigationProvider =
    StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>((ref) =>
        AppRouteConfigStateNotifier(AppRouteConfig.initialPageConfig()));
