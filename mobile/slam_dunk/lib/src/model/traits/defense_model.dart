// To parse this JSON data, do
//
//     final defense = defenseFromJson(jsonString);

import 'dart:convert';

List<Defense> defenseFromJson(String str) => List<Defense>.from(json.decode(str).map((x) => Defense.fromJson(x)));

String defenseToJson(List<Defense> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Defense {
    Defense({
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

    factory Defense.fromJson(Map<String, dynamic> json) => Defense(
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

enum Tag { DEFENSE }

final tagValues = EnumValues({
    "defense": Tag.DEFENSE
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
