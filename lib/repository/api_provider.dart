import 'package:dio/dio.dart';
import 'package:fluttersimple/model/user.dart';

Future<List<User>> loadJson() async {
  Response response;
  response = await Dio()
      .get('https://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2');
  List<User> users = [];
  for (var u in response.data) {
    User user =
        User(u['index'], u['about'], u['name'], u['email'], u['picture']);
    users.add(user);
  }
  print('object');
  return users;
}