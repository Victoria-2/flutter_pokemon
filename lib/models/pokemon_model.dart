import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  String msg;
  Data data;

  Pokemon({
    required this.msg,
    required this.data,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String name;
  int xp;
  String sprite;

  Data({
    required this.id,
    required this.name,
    required this.xp,
    required this.sprite,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        xp: json["xp"],
        sprite: json["sprite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "xp": xp,
        "sprite": sprite,
      };
}
