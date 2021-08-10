


class User {

  int? userId;
  String? username;
  String? email;
  String? name;

  User({this.userId, this.username, this.name, this.email});

  factory User.fromMap(Map<String, dynamic> json) => User(
    userId: json["userId"],
      username: json["username"],
      name: json["name"],
      email: json["email"]
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "username": username,
    "name" : name,
    "email" : email
  };

}