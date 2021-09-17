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

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _savedSuggestions = <WordPair>{};
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Add from here...
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(Icons.list),
          onPressed: _pushSaved
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedSuggestions.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.orange : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedSuggestions.remove(pair);
          } else {
            _savedSuggestions.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return const Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _savedSuggestions
              .map(
                  (WordPair pair) {
                    return ListTile(
                        title: Text(
                          pair.asPascalCase,
                          style: _biggerFont,
                        )
                    );
                  }
              );
          final divided = tiles.isEmpty
              ? <Widget>[]
              : ListTile.divideTiles(
                  context: context,
                  tiles: tiles
                ).toList();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided)
          );
        }
      )
    );
  }
}
