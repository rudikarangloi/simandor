// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

Unit unitFromJson(String str) => Unit.fromJson(json.decode(str));

String unitToJson(Unit data) => json.encode(data.toJson());

class Unit {
  Unit({
    this.kodeUnit,
    this.namaUnit,
  });

  String kodeUnit;
  String namaUnit;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        kodeUnit: json["kode_unit"],
        namaUnit: json["nama_unit"],
      );

  Map<String, dynamic> toJson() => {
        "kode_unit": kodeUnit,
        "nama_unit": namaUnit,
      };

  @override
  String toString() => namaUnit;
}
