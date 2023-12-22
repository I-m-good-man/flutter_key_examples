import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/scaffold_wrapper.dart';

class UndefinedPage extends ConsumerWidget {
  const UndefinedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        wrappedWidget: const Center(
          child: Text('UndefinedPage'),
        ));
  }
}
