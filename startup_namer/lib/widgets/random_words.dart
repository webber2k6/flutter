import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.list),
          onPressed: _pushSaved
      ),
    );
  }

  Widget _buildRow(BuildContext context, WordPair pair) {
    final alreadySaved = _savedSuggestions.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Theme.of(context).primaryColor : null,
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
          return _buildRow(_context, _suggestions[index]);
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