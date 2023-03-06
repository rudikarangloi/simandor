// To parse this JSON data, do
//
//     final objek = objekFromJson(jsonString);

import 'dart:convert';

Objek objekFromJson(String str) => Objek.fromJson(json.decode(str));

String objekToJson(Objek data) => json.encode(data.toJson());

class Objek {
  Objek({
    this.idt,
    this.kdAset,
    this.nmAset,
  });

  String idt;
  String kdAset;
  String nmAset;

  factory Objek.fromJson(Map<String, dynamic> json) => Objek(
        idt: json["IDT"],
        kdAset: json["Kd_Aset"],
        nmAset: json["Nm_Aset"],
      );

  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "Kd_Aset": kdAset,
        "Nm_Aset": nmAset,
      };

  @override
  String toString() => nmAset;
}
