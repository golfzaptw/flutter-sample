import 'package:flutter/material.dart';
import 'package:fluttersimple/model/user.dart';

class DetailPage extends StatelessWidget {
  final User user;

  DetailPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(user.picture),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  user.name,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[Text(user.about)],
                ))
          ],
        ),
      ),
    );
  }
}
