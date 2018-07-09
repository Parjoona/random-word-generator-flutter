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

    return Scaffold (
      appBar: AppBar(
        title: Text('Start Generator'),
        ),
        body: _buildSuggestion(),
    );

    // Displays a single word
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
         style: _biggerFont
      ),
    );
  }
}