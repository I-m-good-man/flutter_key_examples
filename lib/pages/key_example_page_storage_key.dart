import 'package:app_navigation_template/navigation/app_route_config.dart';
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
  int currentIndex = 0;
  PageStorageBucket bucket = PageStorageBucket();

  List<Widget> pages = [
    ColorBoxPage(
      key: PageStorageKey('home'),
    ),
    TextFieldPage(
      key: PageStorageKey('messages'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          ref.read(widget._navigationProvider).pageConfig.last.toString(),
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(widget._navigationProvider.notifier).nextRoute();
              },
              icon: const Icon(Icons.navigate_next))
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: pages[currentIndex],
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
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = PageStorage.of(context).readState(context,
            identifier: PageStorageKey('submitted value')) ??
        PageStorage.of(context).readState(context,
            identifier: PageStorageKey('last inserted value')) ??
        '';

    _controller.addListener(() {
      PageStorage.of(context).writeState(context, _controller.text,
          identifier: PageStorageKey('last inserted value'));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        onSubmitted: (String value) {
          PageStorage.of(context).writeState(context, value,
              identifier: PageStorageKey('submitted value'));
        },
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ));
  }
}
