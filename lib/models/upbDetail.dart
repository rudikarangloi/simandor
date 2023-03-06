// To parse this JSON data, do
//
//     final upbDetail = upbDetailFromJson(jsonString);

import 'dart:convert';

UpbDetail upbDetailFromJson(String str) => UpbDetail.fromJson(json.decode(str));

String upbDetailToJson(UpbDetail data) => json.encode(data.toJson());

class UpbDetail {
  UpbDetail({
    this.idt,
    this.kdUpb,
    this.nmUpb,
    this.kdKelurahan,
    this.idPostgreSql,
  });

  String idt;
  String kdUpb;
  String nmUpb;
  String kdKelurahan;
  String idPostgreSql;

  factory UpbDetail.fromJson(Map<String, dynamic> json) => UpbDetail(
        idt: json["IDT"],
        kdUpb: json["Kd_UPB"],
        nmUpb: json["Nm_UPB"],
        kdKelurahan: json["KdKelurahan"],
        idPostgreSql: json["IdPostgreSQL"],
      );

  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "Kd_UPB": kdUpb,
        "Nm_UPB": nmUpb,
        "KdKelurahan": kdKelurahan,
        "IdPostgreSQL": idPostgreSql,
      };
}
