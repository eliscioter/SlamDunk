// To parse this JSON data, do
//
//     final tricks = tricksFromJson(jsonString);

import 'dart:convert';

List<Tricks> tricksFromJson(String str) => List<Tricks>.from(json.decode(str).map((x) => Tricks.fromJson(x)));

String tricksToJson(List<Tricks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tricks {
    Tricks({
        this.id,
        this.name,
        this.imageUrl,
        this.description,
        this.tag,
    });

    String? id;
    String? name;
    String? imageUrl;
    String? description;
    Tag? tag;

    factory Tricks.fromJson(Map<String, dynamic> json) => Tricks(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["image_url"],
        description: json["description"],
        tag: tagValues.map[json["tag"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image_url": imageUrl,
        "description": description,
        "tag": tagValues.reverse[tag],
    };
}

enum Tag { TRICKS }

final tagValues = EnumValues({
    "tricks": Tag.TRICKS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap;
        return reverseMap;
    }
}
