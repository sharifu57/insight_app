import 'package:insight_app/models/userModel.dart';

class Post {
  int? id;
  String? code;
  String? content;
  String? attachment;
  String? geolocation;
  User? user;

  Post(
      {required this.id,
      required this.code,
      required this.content,
      required this.attachment,
      required this.geolocation,
      required this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        code: json['code'],
        content: json['content'],
        attachment: json['attachment'],
        geolocation: json['geolocation'],
        user: json['user'] != null ? User.fromJson(json['user']) : null);
  }
}
