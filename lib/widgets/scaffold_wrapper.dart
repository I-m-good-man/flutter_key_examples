import 'package:app_navigation_template/navigation/app_route_config.dart';
import 'package:app_navigation_template/pages/key_example_subtree_replacement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_path.dart';

class ScaffoldWrapper extends ConsumerWidget {
  ScaffoldWrapper({required this.wrappedWidget, super.key})
      : _navigationProvider = navigationProvider;

  final Widget wrappedWidget;
  final NavigationProvider _navigationProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text(
          ref.read(_navigationProvider).pageConfig.last.toString(),
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(_navigationProvider.notifier).nextRoute();
              },
              icon: const Icon(Icons.navigate_next))
        ],
      ),
      body: wrappedWidget,
    );
  }
}
