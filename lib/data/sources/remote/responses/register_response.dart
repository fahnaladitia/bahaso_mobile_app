import 'dart:convert';

class PostRegisterResponse {
  int? id;
  String? token;

  PostRegisterResponse({
    this.id,
    this.token,
  });

  factory PostRegisterResponse.fromJson(String str) => PostRegisterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostRegisterResponse.fromMap(Map<String, dynamic> json) => PostRegisterResponse(
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "token": token,
      };
}
