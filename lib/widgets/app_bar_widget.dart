import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_path.dart';
import '../navigation/app_route_config.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget{
  final NavigationProvider _navigationProvider = navigationProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        ref
            .read(_navigationProvider)
            .pageConfig
            .last
            .toString(),
        style: TextStyle(fontSize: 12),
      ),
      actions: [
        IconButton(
            onPressed: () {
              ref.read(_navigationProvider.notifier).nextRoute();
            },
            icon: const Icon(Icons.navigate_next)),
        IconButton(
            onPressed: () {
              ref
                  .read(_navigationProvider.notifier)
                  .pushRoute(appPath: HomePath());
            },
            icon: const Icon(Icons.home))
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}