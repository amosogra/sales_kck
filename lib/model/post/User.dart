
class User {

  int userId;
  String username;
  String email;
  String name;

  User({required this.userId, required this.username, required this.name, required this.email});

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