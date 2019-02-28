import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  get x => null;

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();

    return MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: RandomWords(),

    );
  }
}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);  // Add this line.
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(   // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },// ... to here.
    );


   return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );

  }
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[      // Add 3 lines from here...
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ), body: _buildSuggestions(),
      );

    }
  //final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();   // Add this line.
  //final _biggerFont = const TextStyle(fontSize: 18.0);
  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
            .divideTiles(
          context: context,
          tiles: tiles,
        )
            .toList();
        return new Scaffold(         // Add 6 lines from here...
          appBar: new AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      },
    ),
    );
  }

}



class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

