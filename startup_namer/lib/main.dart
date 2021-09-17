import 'package:flutter/material.dart';
import 'package:startup_namer/widgets/layout_sample.dart';
import 'package:startup_namer/widgets/random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                    icon: Icon(Icons.list_outlined),
                    text: 'Startup Name Generator'
                ),
                Tab(
                    icon: Icon(Icons.layers_outlined),
                    text: 'Layout'
                ),
                Tab(
                    icon: Icon(Icons.hardware_outlined),
                    text: 'Hardware'
                ),
              ]
            ),
            title: const Text('Flutter Workshop'),
          ),
          body: const TabBarView(
            children: [
              RandomWords(),
              LayoutSample(),
              Text("K")
            ]
          ),
        ),
      ),
      // home: const RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.green,
        appBarTheme: const AppBarTheme(
          color: Colors.orange
        ),
      ),
    );
  }
}
