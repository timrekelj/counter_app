import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:async';

//Counter data model
class Counter {
  final int id;
  final String name;
  final double amount;

  Counter({this.id, this.name, this.amount});
}

void main() async {
  //Avoid errors caused by flutter upgrade
  WidgetsFlutterBinding.ensureInitialized();

  //Open the database and store reference
  final Future<Database> database = openDatabase(

      //Set the path to database
      join(await getDatabasesPath(), 'counter_database.db'),

      //When the database is first created, create a table to store different counters
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE counter(ID INTEGER PRIMARY KEY, name TEXT, amount INTEGER)");
  }, version: 1);

  runApp(MyApp());
}

Future<void> insertCounters(Counter counter) async {
  //https://flutter.dev/docs/cookbook/persistence/sqlite
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
