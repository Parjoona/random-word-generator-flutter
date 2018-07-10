import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RandomWordsAreFun',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];

  final _saved = Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    Widget _buildSuggestion() {
      return ListView.builder(
        padding: const EdgeInsets.all(18.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }

      );
    }

    // Returns everything on display.
    return Scaffold (
      appBar: AppBar(
        title: Text('Start Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildSuggestion(),
    );

    // Displays a single word
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
  }

  Widget _buildRow(WordPair pair) {
    final checkSaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
         style: _biggerFont
      ),
      trailing: Icon(
        checkSaved ? Icons.favorite : Icons.favorite_border,
        color: checkSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          checkSaved ? _saved.remove(pair) : _saved.add(pair);
      });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont
                  ),
              );
            }
          );

          final divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles
            )
            .toList();

          return Scaffold(appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}