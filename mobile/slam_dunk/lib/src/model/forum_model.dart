import 'dart:convert';

List<Forums> forumsFromJson(String str) => List<Forums>.from(json.decode(str.toString()).map((x) => Forums.fromJson(x)));

String forumsToJson(List<Forums> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forums {
  Forums({
    this.id,
    this.title,
    this.primaryAuthor,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? primaryAuthor;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Forums.fromJson(Map<String, dynamic> json) => Forums(
      id: json["_id"],
      title: json["title"],
      primaryAuthor: json["primary_author"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "primary_author": primaryAuthor,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
