import 'package:flutter/material.dart';
import 'item_json.dart';
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