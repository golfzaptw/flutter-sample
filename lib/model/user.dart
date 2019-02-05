// class User {
//   final String index, about, email, name, picture;

//   User(this.index, this.about, this.email, this.name, this.picture);

//   User.fromJson(Map<String, dynamic> json)
//       : index = json["index"].toString(),
//         about = json["about"],
//         email = json["email"],
//         name = json["name"],
//         picture = json["picture"];
// }

// class UserList {
//   final List<User> users;

//   UserList({
//     this.users,
//   });

//   factory UserList.fromJson(List<dynamic> parsedJson) {
//     List<User> users = new List<User>();
//     users = parsedJson.map((i) => User.fromJson(i)).toList();
//     return new UserList(users: users);
//   }
// }

class User {
  final int index;
  final String about, name, email, picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}
