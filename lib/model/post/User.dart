


class User {

  int? userId;
  String? firstName;
  String? lastName;
  String? email;

  User({this.userId, this.firstName, this.lastName, this.email});

  factory User.fromMap(Map<String, dynamic> json) => User(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"]
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "firstName": firstName,
    "lastName" : lastName,
    "email" : email
  };

}