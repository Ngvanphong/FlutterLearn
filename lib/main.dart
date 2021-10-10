import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MaterialApp(
      theme: ThemeData(
        //primaryColor: Colors.amber,
        primarySwatch: Colors.amber
      ) ,
      title: "This is title of material app",
      home:  const ContextStateful(),

    );
  }
}

class ContextStateful extends StatefulWidget {
  const ContextStateful({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandomList();
  }
}

class RandomList extends State<ContextStateful> {
  final List<WordPair> _listWordPair = <WordPair>[];
  final Set<WordPair> _saved = <WordPair>{};
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is title of appbar"),
        actions: [
          IconButton(
            onPressed: _gotoListFavorite,
            icon: const Icon(Icons.list),
            tooltip: "This is tooltip of IconButton",
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) return const Divider();
            if (index >= _listWordPair.length) {
              _listWordPair.addAll(generateWordPairs().take(10));
            }
            return _buildRowListView(_listWordPair[index]);
          },
          padding: const EdgeInsets.all(8),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
          tooltip: "This is float action button",
          onPressed: null,
          child: Icon(Icons.add)),
    );
  }

  Widget _buildRowListView(WordPair wordPair) {
    final bool _isSave = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asUpperCase,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        _isSave ? Icons.favorite : Icons.favorite_border,
        color: _isSave ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_isSave) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _gotoListFavorite() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> titles = _saved.map((pair) {
        return ListTile(
          title: Text(pair.asUpperCase),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(tiles: titles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text("This is title of save favorite"),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
