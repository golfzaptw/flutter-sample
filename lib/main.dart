import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'color_loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WTF',
      theme: new ThemeData(primaryColor: Colors.black),
      home: new GetAPI(),
    );
  }
}

// set state

class GetAPI extends StatefulWidget {
  @override
  _GetAPIState createState() => new _GetAPIState();
}

// working function

class _GetAPIState extends State<GetAPI> {
  // list color to use in color loader
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];

  // use future and Dio to call api and return item
  Future<List<ItemJSON>> _getItem() async {
    Response response;
    response = await Dio()
        .get('https://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2');
    var responseData = response.data;
    // await new Future.delayed(new Duration(seconds: 2));
    List<ItemJSON> items = [];
    for (var user in responseData) {
      ItemJSON item = ItemJSON(user['index'], user['about'], user['email'],
          user['name'], user['picture']);
      items.add(item);
    }
    print(items.length);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // get item from function and set listview
    var futureBuilder = FutureBuilder(
        future: _getItem(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return ColorLoader(colors: colors,duration: Duration(milliseconds: 1200),);
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].picture),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailList(snapshot.data[index])));
                    },
                  );
                },
              );
          }
          return null;
        });

    return Scaffold(
      appBar: AppBar(
        title: Text('Get List User'),
      ),
      body: Container(
        child: futureBuilder,
      ),
    );
  }
}

// StatelessWidget = new page

class DetailList extends StatelessWidget {
  final ItemJSON item;
  DetailList(this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Container(
        child: Text(item.about),
      ),
    );
  }
}

// variable in json

class ItemJSON {
  final int index;
  final String about, email, name, picture;
  ItemJSON(this.index, this.about, this.email, this.name, this.picture);
}
