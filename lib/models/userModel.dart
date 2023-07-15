class User {
  int? id;
  String? username;
  String? first_name;
  String? last_name;
  String? email;
  String? password;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.username,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
