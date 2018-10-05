import 'dart:convert';

import 'package:dt_benchmark_app/models/campus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primarySwatch: Colors.deepPurple, accentColor: Colors.cyan),
      home: new MyHomePage(title: 'Campuses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Campus> _campuses = [];

  void _pullCampuses() async {
    var response =
        await http.get("https://benchmark.mattclark.guru/campuses.json");
    if (response.statusCode >= 200 && response.statusCode < 400) {
      print(response.body);
      var data = json.decode(response.body);
      List<Campus> tmp = [];
      for (var item in data) {
        tmp.add(Campus.fromJson(item));
      }
      setState(() {
        _campuses = tmp;
      });
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Widget _BuildCampus(Campus campus) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(Icons.location_city),
          Text(campus.name),
        ],
      ),
      subtitle: Text("created_at: ${campus.createdAt}"),
    );
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: _campuses.length,
      itemBuilder: (context, index) {
        var campus = _campuses[index];
        return _BuildCampus(campus);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _pullCampuses,
          ),
        ],
      ),
      body: buildBody(),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _pullCampuses,
//        tooltip: 'Get Campuses',
//        child: new Icon(Icons.search),
//      ),
    );
  }
}
