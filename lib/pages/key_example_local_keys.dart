import 'dart:math';

import 'package:app_navigation_template/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyExampleLocalKeysPage extends ConsumerWidget {
  const KeyExampleLocalKeysPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        wrappedWidget: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                List<Color> newConfig =
                    ref.read(colorSquareConfigProvider).config..shuffle();
                ref.read(colorSquareConfigProvider.notifier).update(newConfig);
              },
              icon: Icon(Icons.update)),
          ValueKeyExample(),
          ObjectKeyExample(),
          UniqueKeyExample()
        ],
      ),
    ));
  }
}

class ColorSquareConfig {
  final List<Color> config;

  ColorSquareConfig({required this.config});

  ColorSquareConfig copyWith({
    List<Color>? config,
  }) {
    return ColorSquareConfig(
      config: config ?? this.config,
    );
  }
}

class ColorSquareConfigStateNotifier extends StateNotifier<ColorSquareConfig> {
  ColorSquareConfigStateNotifier(super.state);

  void update(List<Color> config) {
    state = state.copyWith(config: config);
  }
}

final colorSquareConfigProvider = StateNotifierProvider<
        ColorSquareConfigStateNotifier, ColorSquareConfig>(
    (ref) => ColorSquareConfigStateNotifier(
        ColorSquareConfig(config: [Colors.black, Colors.green, Colors.red])));

class ValueKeyExample extends ConsumerWidget {
  ValueKeyExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(colorSquareConfigProvider);
    return Row(
      children: [
        for (Color color in ref.read(colorSquareConfigProvider).config)
          StatefulColorSquare(color: color, key: ValueKey(color))
      ],
    );
  }
}

class ObjectKeyExample extends ConsumerWidget {
  ObjectKeyExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(colorSquareConfigProvider);
    return Row(
      children: [
        for (Color color in ref.read(colorSquareConfigProvider).config)
          StatefulColorSquare(color: color, key: ObjectKey(color))
      ],
    );
  }
}

class UniqueKeyExample extends ConsumerWidget {
  UniqueKeyExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(colorSquareConfigProvider);
    return Row(
      children: [
        for (Color color in ref.read(colorSquareConfigProvider).config)
          StatefulColorSquare(color: color, key: UniqueKey())
      ],
    );
  }
}

class StatefulColorSquare extends StatefulWidget {
  const StatefulColorSquare({required this.color, super.key});

  final Color color;

  @override
  State<StatefulColorSquare> createState() => _StatefulColorSquareState();
}

class _StatefulColorSquareState extends State<StatefulColorSquare> {
  late Color color;

  @override
  void initState() {
    super.initState();

    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          color = Colors.brown;
        });
      },
      child: Container(
        color: color,
        width: 70,
        height: 70,
      ),
    );
  }
}
