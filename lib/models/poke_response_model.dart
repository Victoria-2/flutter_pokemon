import 'dart:convert';

PokeResponse pokeResponseFromJson(String str) =>
    PokeResponse.fromJson(json.decode(str));

String pokeResponseToJson(PokeResponse data) => json.encode(data.toJson());

class PokeResponse {
  String msg;
  Data data;

  PokeResponse({
    required this.msg,
    required this.data,
  });

  factory PokeResponse.fromJson(Map<String, dynamic> json) => PokeResponse(
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  int count;
  String next;
  String? previous;
  List<Result> results;

  Data({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String name;
  String url;

  Result({
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
