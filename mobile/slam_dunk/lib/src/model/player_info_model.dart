// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
    Player({
        this.player,
        this.id,
        this.tag,
        this.v,
    });

    PlayerClass? player;
    String? id;
    String? tag;
    int? v;

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        player: PlayerClass.fromJson(json["player"]),
        id: json["_id"],
        tag: json["tag"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "player": player?.toJson(),
        "_id": id,
        "tag": tag,
        "__v": v,
    };
}

class PlayerClass {
    PlayerClass({
        this.profile,
        this.attributes,
        this.talents,
    });

    Profile? profile;
    Attributes? attributes;
    Talents? talents;

    factory PlayerClass.fromJson(Map<String, dynamic> json) => PlayerClass(
        profile: Profile.fromJson(json["profile"]),
        attributes: Attributes.fromJson(json["attributes"]),
        talents: Talents.fromJson(json["talents"]),
    );

    Map<String, dynamic> toJson() => {
        "profile": profile?.toJson(),
        "attributes": attributes?.toJson(),
        "talents": talents?.toJson(),
    };
}

class Attributes {
    Attributes({
        this.general,
        this.offense,
        this.defense,
    });

    General? general;
    Offense? offense;
    Defense? defense;

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        general: General.fromJson(json["general"]),
        offense: Offense.fromJson(json["offense"]),
        defense: Defense.fromJson(json["defense"]),
    );

    Map<String, dynamic> toJson() => {
        "general": general?.toJson(),
        "offense": offense?.toJson(),
        "defense": defense?.toJson(),
    };
}

class Defense {
    Defense({
        this.reb,
        this.blk,
        this.jam,
        this.stl,
    });

    double? reb;
    int? blk;
    int? jam;
    int? stl;

    factory Defense.fromJson(Map<String, dynamic> json) => Defense(
        reb: json["reb"].toDouble(),
        blk: json["blk"],
        jam: json["jam"],
        stl: json["stl"],
    );

    Map<String, dynamic> toJson() => {
        "reb": reb,
        "blk": blk,
        "jam": jam,
        "stl": stl,
    };
}

class General {
    General({
        this.control,
        this.strength,
        this.res,
        this.jump,
        this.run,
        this.dribble,
    });

    int? control;
    double? strength;
    int? res;
    int? jump;
    int? run;
    int? dribble;

    factory General.fromJson(Map<String, dynamic> json) => General(
        control: json["control"],
        strength: json["strength"].toDouble(),
        res: json["res"],
        jump: json["jump"],
        run: json["run"],
        dribble: json["dribble"],
    );

    Map<String, dynamic> toJson() => {
        "control": control,
        "strength": strength,
        "res": res,
        "jump": jump,
        "run": run,
        "dribble": dribble,
    };
}

class Offense {
    Offense({
        this.close,
        this.middle,
        this.threePointer,
        this.dunk,
        this.layup,
    });

    int? close;
    int? middle;
    int? threePointer;
    double? dunk;
    int? layup;

    factory Offense.fromJson(Map<String, dynamic> json) => Offense(
        close: json["close"],
        middle: json["middle"],
        threePointer: json["three_pointer"],
        dunk: json["dunk"].toDouble(),
        layup: json["layup"],
    );

    Map<String, dynamic> toJson() => {
        "close": close,
        "middle": middle,
        "three_pointer": threePointer,
        "dunk": dunk,
        "layup": layup,
    };
}

class Profile {
    Profile({
        this.playerName,
        this.position,
        this.imageUrl,
        this.school,
        this.height,
        this.weight,
        this.description,
    });

    PlayerName? playerName;
    Position? position;
    String? imageUrl;
    String? school;
    int? height;
    int? weight;
    String? description;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        playerName: PlayerName.fromJson(json["player_name"]),
        position: Position.fromJson(json["position"]),
        imageUrl: json["image_url"],
        school: json["school"],
        height: json["height"],
        weight: json["weight"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "player_name": playerName?.toJson(),
        "position": position?.toJson(),
        "image_url": imageUrl,
        "school": school,
        "height": height,
        "weight": weight,
        "description": description,
    };
}

class PlayerName {
    PlayerName({
        this.firstName,
        this.lastName,
    });

    String? firstName;
    String? lastName;

    factory PlayerName.fromJson(Map<String, dynamic> json) => PlayerName(
        firstName: json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
    };
}

class Position {
    Position({
        this.abbr,
        this.fullVersion,
    });

    String? abbr;
    String? fullVersion;

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        abbr: json["abbr"],
        fullVersion: json["full_version"],
    );

    Map<String, dynamic> toJson() => {
        "abbr": abbr,
        "full_version": fullVersion,
    };
}

class Talents {
    Talents({
        this.talent1,
        this.talent2,
        this.talent3,
        this.talent4,
        this.talent5,
        this.talent6,
    });

    Talent? talent1;
    Talent? talent2;
    Talent? talent3;
    Talent? talent4;
    Talent? talent5;
    Talent? talent6;

    factory Talents.fromJson(Map<String, dynamic> json) => Talents(
        talent1: Talent.fromJson(json["talent1"]),
        talent2: Talent.fromJson(json["talent2"]),
        talent3: Talent.fromJson(json["talent3"]),
        talent4: Talent.fromJson(json["talent4"]),
        talent5: Talent.fromJson(json["talent5"]),
        talent6: Talent.fromJson(json["talent6"]),
    );

    Map<String, dynamic> toJson() => {
        "talent1": talent1?.toJson(),
        "talent2": talent2?.toJson(),
        "talent3": talent3?.toJson(),
        "talent4": talent4?.toJson(),
        "talent5": talent5?.toJson(),
        "talent6": talent6?.toJson(),
    };
}

class Talent {
    Talent({
        this.name,
        this.description,
        this.talentImageUrl,
        this.id,
    });

    String? name;
    String? description;
    String? talentImageUrl;
    String? id;

    factory Talent.fromJson(Map<String, dynamic> json) => Talent(
        name: json["name"],
        description: json["description"],
        talentImageUrl: json["talent_image_url"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "talent_image_url": talentImageUrl,
        "_id": id,
    };
}
