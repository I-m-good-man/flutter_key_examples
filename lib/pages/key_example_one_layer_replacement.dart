import 'package:app_navigation_template/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyExampleOneLayerReplacementPage extends ConsumerWidget {
  const KeyExampleOneLayerReplacementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWrapper(
        wrappedWidget: Center(
      child: Column(
        children: [StatelessWidgetReplacement()],
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

class StatelessWidgetReplacement extends ConsumerWidget {
  const StatelessWidgetReplacement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              List<Color> newConfig = ref.read(colorSquareConfigProvider).config
                ..shuffle();
              ref.read(colorSquareConfigProvider.notifier).update(newConfig);
            },
            icon: const Icon(Icons.update)),
        for (Color color in ref.read(colorSquareConfigProvider).config)
          StatelessColorSquare(color: color)
      ],
    );
  }
}

class StatelessColorSquare extends StatelessWidget {
  const StatelessColorSquare({required this.color, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 70,
      height: 70,
    );
  }
}
