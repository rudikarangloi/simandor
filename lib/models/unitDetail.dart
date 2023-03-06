// To parse this JSON data, do
//
//     final unitDetail = unitDetailFromJson(jsonString);

import 'dart:convert';

UnitDetail unitDetailFromJson(String str) =>
    UnitDetail.fromJson(json.decode(str));

String unitDetailToJson(UnitDetail data) => json.encode(data.toJson());

class UnitDetail {
  UnitDetail({
    this.idt,
    this.idPostgreSql,
    this.kdUnit,
    this.nmUnit,
    this.kdUnitLink,
    this.nmUnitLink,
    this.nmaPimpinan,
    this.nipPimpinan,
    this.jabPimpinan,
    this.pktPimpinan,
    this.hpPimpinan,
    this.pinPimpinan,
    this.emaPimpinan,
    this.nmPengurus,
    this.nipPengurus,
    this.jbtPengurus,
    this.hpPengurus,
    this.pinPengurus,
    this.emaPengurus,
    this.nmPenyimpan,
    this.nipPenyimpan,
    this.jbtPenyimpan,
    this.hpPenyimpan,
    this.pinPenyimpan,
    this.emaPenyimpan,
  });

  String idt;
  String idPostgreSql;
  String kdUnit;
  String nmUnit;
  String kdUnitLink;
  String nmUnitLink;
  String nmaPimpinan;
  String nipPimpinan;
  String jabPimpinan;
  String pktPimpinan;
  String hpPimpinan;
  String pinPimpinan;
  String emaPimpinan;
  String nmPengurus;
  String nipPengurus;
  String jbtPengurus;
  String hpPengurus;
  String pinPengurus;
  String emaPengurus;
  String nmPenyimpan;
  String nipPenyimpan;
  String jbtPenyimpan;
  String hpPenyimpan;
  String pinPenyimpan;
  String emaPenyimpan;

  factory UnitDetail.fromJson(Map<String, dynamic> json) => UnitDetail(
        idt: json["IDT"],
        idPostgreSql: json["IdPostgreSQL"],
        kdUnit: json["Kd_Unit"],
        nmUnit: json["Nm_Unit"],
        kdUnitLink: json["Kd_Unit_Link"],
        nmUnitLink: json["Nm_Unit_Link"],
        nmaPimpinan: json["Nma_Pimpinan"],
        nipPimpinan: json["Nip_Pimpinan"],
        jabPimpinan: json["Jab_Pimpinan"],
        pktPimpinan: json["Pkt_Pimpinan"],
        hpPimpinan: json["Hp_Pimpinan"],
        pinPimpinan: json["Pin_Pimpinan"],
        emaPimpinan: json["Ema_Pimpinan"],
        nmPengurus: json["Nm_Pengurus"],
        nipPengurus: json["Nip_Pengurus"],
        jbtPengurus: json["Jbt_Pengurus"],
        hpPengurus: json["Hp_Pengurus"],
        pinPengurus: json["Pin_Pengurus"],
        emaPengurus: json["Ema_Pengurus"],
        nmPenyimpan: json["Nm_Penyimpan"],
        nipPenyimpan: json["Nip_Penyimpan"],
        jbtPenyimpan: json["Jbt_Penyimpan"],
        hpPenyimpan: json["Hp_Penyimpan"],
        pinPenyimpan: json["Pin_Penyimpan"],
        emaPenyimpan: json["Ema_Penyimpan"],
      );

  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "IdPostgreSQL": idPostgreSql,
        "Kd_Unit": kdUnit,
        "Nm_Unit": nmUnit,
        "Kd_Unit_Link": kdUnitLink,
        "Nm_Unit_Link": nmUnitLink,
        "Nma_Pimpinan": nmaPimpinan,
        "Nip_Pimpinan": nipPimpinan,
        "Jab_Pimpinan": jabPimpinan,
        "Pkt_Pimpinan": pktPimpinan,
        "Hp_Pimpinan": hpPimpinan,
        "Pin_Pimpinan": pinPimpinan,
        "Ema_Pimpinan": emaPimpinan,
        "Nm_Pengurus": nmPengurus,
        "Nip_Pengurus": nipPengurus,
        "Jbt_Pengurus": jbtPengurus,
        "Hp_Pengurus": hpPengurus,
        "Pin_Pengurus": pinPengurus,
        "Ema_Pengurus": emaPengurus,
        "Nm_Penyimpan": nmPenyimpan,
        "Nip_Penyimpan": nipPenyimpan,
        "Jbt_Penyimpan": jbtPenyimpan,
        "Hp_Penyimpan": hpPenyimpan,
        "Pin_Penyimpan": pinPenyimpan,
        "Ema_Penyimpan": emaPenyimpan,
      };
}
