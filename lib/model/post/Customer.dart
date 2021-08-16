


class Customer {

  int userId;
  String username;
  String email;
  String name;

  Customer({required this.userId, required this.username, required this.name, required this.email});

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
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