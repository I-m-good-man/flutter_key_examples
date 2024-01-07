import 'dart:io';
import 'dart:math';

import 'package:app_navigation_template/widgets/app_bar_widget.dart';
import 'package:app_navigation_template/widgets/scaffold_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_route_config.dart';

class KeyExampleGlobalKeyPage extends ConsumerStatefulWidget {
  KeyExampleGlobalKeyPage({super.key})
      : _navigationProvider = navigationProvider;
  final NavigationProvider _navigationProvider;

  @override
  ConsumerState createState() {
    return KeyExamplePageStorageKeyPageState();
  }
}

class KeyExamplePageStorageKeyPageState
    extends ConsumerState<KeyExampleGlobalKeyPage> {
  int currentIndex = 0;

  late GlobalObjectKey<_StatefulColorSquareState> _globalKey;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalObjectKey('ColorSquareBlock global key');
  }

  @override
  Widget build(BuildContext context) {
    // _globalKey = GlobalObjectKey('ColorSquareBlock global key');
    return Scaffold(
      appBar: AppBarWidget(),
      body: GestureDetector(
        onLongPress: () {
          print(_globalKey.currentState);
          print(_globalKey.currentState?.counter);
          print(_globalKey.currentState?.color);
          print(_globalKey.currentContext);
          print(Scaffold.of(_globalKey.currentContext!).hasAppBar);
          print(_globalKey.currentWidget == _globalKey.currentState?.widget);
          print(_globalKey);
        },
        child: switch (currentIndex) {
          0 => StatefulColorSquare(
              Colors.black,
              key: _globalKey,
            ),
          1 => StatefulColorSquare(
              Colors.red,
              key: _globalKey,
            ),
          _ => throw Exception('error')
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages')
        ],
      ),
    );
  }
}

class StatefulColorSquare extends StatefulWidget {
  const StatefulColorSquare(this.color, {super.key});

  final Color color;

  @override
  State<StatefulColorSquare> createState() => _StatefulColorSquareState();
}

class _StatefulColorSquareState extends State<StatefulColorSquare> {
  late Color color;
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = 0;
    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            counter += 1;
            color = (color == Colors.black) ? Colors.red : Colors.black;
          });
        },
        child: Container(
          color: color,
          width: 70,
          height: 70,
          child: Center(
            child: Text(
              '$counter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
