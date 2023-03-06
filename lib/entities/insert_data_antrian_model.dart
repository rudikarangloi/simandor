// To parse this JSON data, do
//
//     final responseInsertDataAntrian = responseInsertDataAntrianFromJson(jsonString);

import 'dart:convert';

ResponseVerifyData responseInsertDataAntrianFromJson(String str) => ResponseVerifyData.fromJson(json.decode(str));

String responseInsertDataAntrianToJson(ResponseVerifyData data) => json.encode(data.toJson());

class ResponseVerifyData {
  ResponseVerifyData({
    this.msg,
    this.kode_barang,
    this.state,
  });

  String msg;
  String kode_barang;
  String state;

  factory ResponseVerifyData.fromJson(Map<String, dynamic> json) => ResponseVerifyData(
    msg: json["msg"],
    kode_barang: json["jmlCountId"],
    state: json["KodeBookings"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "jmlCountId": kode_barang,
    "KodeBookings": state,
  };
}
