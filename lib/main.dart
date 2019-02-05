import 'package:flutter/material.dart';
import 'package:fluttersimple/repository/api_provider.dart';
import 'package:fluttersimple/model/user.dart';
import 'package:fluttersimple/views/detail.dart';
import 'package:fluttersimple/loader/color_loader.dart';

void main() => runApp(MyApp(
      title: 'Contact User',
    ));

class MyApp extends StatefulWidget {
  final String title;

  MyApp({Key key, @required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Future<List<User>> futureJsonResponse;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];
  @override
  void initState() {
    super.initState();
    futureJsonResponse = loadJson();
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder<List<User>>(
      future:
          futureJsonResponse, // a previously-obtained Future<String> or null
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('ConnectionState.none');
          case ConnectionState.active:
            return Text('ConnectionState.active');
          case ConnectionState.waiting:
            return ColorLoader5(
              dotOneColor: Colors.redAccent,
              dotTwoColor: Colors.blueAccent,
              dotThreeColor: Colors.green,
              dotType: DotType.circle,
              dotIcon: Icon(Icons.adjust),
              duration: Duration(seconds: 1),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[i].picture),
                  ),
                  title: Text(snapshot.data[i].name),
                  subtitle: Text(snapshot.data[i].email),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  user: snapshot.data[i],
                                )));
                  },
                );
              },
            );
        }
        return null; // unreachable
      },
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print('Reloading');
                setState(() {
                  futureJsonResponse = loadJson();
                });
              },
            )
          ],
        ),
        body: Center(
          child: futureBuilder,
        ),
      ),
    );
  }
}
