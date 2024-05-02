import 'dart:convert';

class PostLoginResponse {
  String? token;

  PostLoginResponse({
    this.token,
  });

  factory PostLoginResponse.fromJson(String str) => PostLoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostLoginResponse.fromMap(Map<String, dynamic> json) => PostLoginResponse(
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
      };
}
