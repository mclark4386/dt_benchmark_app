// To parse this JSON data, do
//
//     final campus = campusFromJson(jsonString);

import 'dart:convert';

Campus campusFromJson(String str) {
  final jsonData = json.decode(str);
  return Campus.fromJson(jsonData);
}

String campusToJson(Campus data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Campus {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  dynamic admins;

  Campus({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.admins,
  });

  factory Campus.fromJson(Map<String, dynamic> json) => new Campus(
        id: json.containsKey("id") ? json["id"] : "<unknown>",
        createdAt: DateTime.parse(json["created_at"] ?? ""),
        updatedAt: DateTime.parse(json["updated_at"] ?? ""),
        name: json["name"] ?? "",
        admins: json["Admins"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
        "Admins": admins,
      };
}
