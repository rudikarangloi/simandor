// To parse this JSON data, do
//
//     final ruangDetail = ruangDetailFromJson(jsonString);

import 'dart:convert';

RuangDetail ruangDetailFromJson(String str) =>
    RuangDetail.fromJson(json.decode(str));

String ruangDetailToJson(RuangDetail data) => json.encode(data.toJson());

class RuangDetail {
  RuangDetail({
    this.idt,
    this.bpKode,
    this.unitKode,
    this.sunitKode,
    this.ssunitKode,
    this.kdUpb,
    this.kdRuang,
    this.nmRuang,
    this.noRuang,
    this.nmPejabat,
    this.nipPejabat,
    this.nmJabatan,
    this.noUrut,
  });

  String idt;
  dynamic bpKode;
  dynamic unitKode;
  dynamic sunitKode;
  dynamic ssunitKode;
  String kdUpb;
  String kdRuang;
  String nmRuang;
  String noRuang;
  String nmPejabat;
  String nipPejabat;
  String nmJabatan;
  String noUrut;

  factory RuangDetail.fromJson(Map<String, dynamic> json) => RuangDetail(
        idt: json["IDT"],
        bpKode: json["bp_kode"],
        unitKode: json["unit_kode"],
        sunitKode: json["sunit_kode"],
        ssunitKode: json["ssunit_kode"],
        kdUpb: json["Kd_UPB"],
        kdRuang: json["Kd_Ruang"],
        nmRuang: json["Nm_Ruang"],
        noRuang: json["No_Ruang"],
        nmPejabat: json["Nm_Pejabat"],
        nipPejabat: json["Nip_Pejabat"],
        nmJabatan: json["Nm_Jabatan"],
        noUrut: json["No_Urut"],
      );

  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "bp_kode": bpKode,
        "unit_kode": unitKode,
        "sunit_kode": sunitKode,
        "ssunit_kode": ssunitKode,
        "Kd_UPB": kdUpb,
        "Kd_Ruang": kdRuang,
        "Nm_Ruang": nmRuang,
        "No_Ruang": noRuang,
        "Nm_Pejabat": nmPejabat,
        "Nip_Pejabat": nipPejabat,
        "Nm_Jabatan": nmJabatan,
        "No_Urut": noUrut,
      };
}
