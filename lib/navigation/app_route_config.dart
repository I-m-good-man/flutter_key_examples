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

  void pushRoute({required AppPath appPath}) {
    state = state.copyWith(pageConfig: state.pageConfig..add(appPath));
  }

  void popRoute() {
    state = state.copyWith(pageConfig: state.pageConfig..removeLast());
  }

  void nextRoute() {
    List<AppPath> pageConfig = state.pageConfig;
    // List<AppPath> newPageConfig = pageConfig
    //   ..add(switch (pageConfig.last.runtimeType) {
    //     LaunchPath => HomePath(),
    //     HomePath => KeyExampleOneLayerReplacementPath(),
    //     KeyExampleOneLayerReplacementPath => KeyExampleSubtreeReplacementPath(),
    //     KeyExampleSubtreeReplacementPath => KeyExampleLocalKeysPath(),
    //     KeyExampleLocalKeysPath => KeyExamplePageStorageKeyPath(),
    //     KeyExamplePageStorageKeyPath => KeyExampleGlobalKeyPath(),
    //     KeyExampleGlobalKeyPath => LaunchPath(),
    //     _ => throw Exception('undefined path')
    //   });
    List<AppPath> newPageConfig = [
      HomePath(),
      switch (pageConfig.last.runtimeType) {
        LaunchPath => HomePath(),
        HomePath => KeyExampleOneLayerReplacementPath(),
        KeyExampleOneLayerReplacementPath => KeyExampleSubtreeReplacementPath(),
        KeyExampleSubtreeReplacementPath => KeyExampleLocalKeysPath(),
        KeyExampleLocalKeysPath => KeyExamplePageStorageKeyPath(),
        KeyExamplePageStorageKeyPath => KeyExampleGlobalKeyPath(),
        KeyExampleGlobalKeyPath => LaunchPath(),
        _ => throw Exception('undefined path')
      }
    ];
    state = state.copyWith(pageConfig: newPageConfig);
  }
}

typedef NavigationProvider
    = StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>;

final NavigationProvider navigationProvider =
    StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>((ref) =>
        AppRouteConfigStateNotifier(AppRouteConfig(pageConfig: [HomePath()])));
