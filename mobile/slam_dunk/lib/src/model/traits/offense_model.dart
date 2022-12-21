// To parse this JSON data, do
//
//     final offense = offenseFromJson(jsonString);

import 'dart:convert';

List<Offense> offenseFromJson(String str) => List<Offense>.from(json.decode(str).map((x) => Offense.fromJson(x)));

String offenseToJson(List<Offense> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offense {
    Offense({
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

    factory Offense.fromJson(Map<String, dynamic> json) => Offense(
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

enum Tag { OFFENSE }

final tagValues = EnumValues({
    "offense": Tag.OFFENSE
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
