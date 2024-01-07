import 'package:app_navigation_template/navigation/app_path.dart';
import 'package:app_navigation_template/navigation/app_route_config.dart';
import 'package:app_navigation_template/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final Map<String, AppPath> _buttonTextToAppPathMap = {
    'KeyExampleOneLayerReplacement': KeyExampleOneLayerReplacementPath(),
    'KeyExampleSubtreeReplacement': KeyExampleSubtreeReplacementPath(),
    'KeyExampleLocalKeys': KeyExampleLocalKeysPath(),
    'KeyExamplePageStorageKey': KeyExamplePageStorageKeyPath(),
    'KeyExampleGlobalKey': KeyExampleGlobalKeyPath()
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        wrappedWidget: Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (MapEntry mapEntry in _buttonTextToAppPathMap.entries)
            PageButton(mapEntry.key, mapEntry.value)
        ],
      ),
    ));
  }
}

class PageButton extends ConsumerWidget {
  final NavigationProvider _navigationProvider = navigationProvider;

  final String _buttonText;
  final AppPath _appPath;

  PageButton(this._buttonText, this._appPath);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          ref.read(_navigationProvider.notifier).setNewState(
              newState: AppRouteConfig(pageConfig: [HomePath(), _appPath]));
        },
        child: Text(_buttonText));
  }
}
