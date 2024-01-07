import 'package:app_navigation_template/navigation/app_route_config.dart';
import 'package:app_navigation_template/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyExamplePageStorageKeyPage extends ConsumerStatefulWidget {
  KeyExamplePageStorageKeyPage({super.key})
      : _navigationProvider = navigationProvider;
  final NavigationProvider _navigationProvider;

  @override
  ConsumerState createState() {
    return KeyExamplePageStorageKeyPageState();
  }
}

class KeyExamplePageStorageKeyPageState
    extends ConsumerState<KeyExamplePageStorageKeyPage> {
  late int _currentIndex;
  late PageStorageBucket _bucket;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _bucket = PageStorageBucket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: PageStorage(
        bucket: _bucket,
        child: switch (_currentIndex) {
          0 => ColorBoxPage(
              key: PageStorageKey('Home page'),
            ),
          1 => ColorBoxPage(
              key: PageStorageKey('Messages page'),
            ),
          2 => TextFieldPage(),
          _ => throw Exception(
              'Invalid value in parameter _currentIndex: $_currentIndex')
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class ColorBoxPage extends StatelessWidget {
  const ColorBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (BuildContext context, int index) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          color: index.isEven ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class TextFieldPage extends StatefulWidget {
  @override
  State<TextFieldPage> createState() => _TextFieldPageState();

  const TextFieldPage({super.key});
}

class _TextFieldPageState extends State<TextFieldPage> {
  late TextEditingController _controller;

  PageStorageBucket get _pageStorageBucket => PageStorage.of(context);
  late PageStorageKey _textFieldKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _textFieldKey = PageStorageKey('Text field key');
    _controller.text =
        _pageStorageBucket.readState(context, identifier: _textFieldKey) ??
            'Initial text';
    _controller.addListener(() {
      _pageStorageBucket.writeState(context, _controller.text,
          identifier: _textFieldKey);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          )),
    );
  }
}
