import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
    Member({
        this.accessToken,
        this.refreshToken,
        this.username,
        this.role,
    });

    String? accessToken;
    String? refreshToken;
    String? username;
    List<dynamic>? role;

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        username: json["username"],
        role: List<String>.from(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "username": username,
        "role": List<dynamic>.from(role!),
    };
}
