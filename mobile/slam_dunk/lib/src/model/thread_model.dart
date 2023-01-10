import 'dart:convert';

Thread? threadFromJson(String str) => Thread.fromJson(json.decode(str));

String threadToJson(Thread? data) => json.encode(data!.toJson());

class Thread {
    Thread({
        this.id,
        this.title,
        this.primaryAuthor,
        this.body,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? title;
    String? primaryAuthor;
    List<Body?>? body;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        id: json["_id"],
        title: json["title"],
        primaryAuthor: json["primary_author"],
        body: json["body"] == null ? [] : List<Body?>.from(json["body"]!.map((x) => Body.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "primary_author": primaryAuthor,
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x!.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Body {
    Body({
        this.author,
        this.id,
        this.content,
    });

    String? author;
    String? id;
    String? content;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        author: json["author"],
        id: json["_id"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "_id": id,
        "content": content,
    };
}
