import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'constants.dart';
import 'functions/currencyFormat.dart';
import 'home.dart';
import 'models/barang.dart';
import 'models/objek.dart';
import 'models/unit.dart';

class Formkib extends StatefulWidget {
  final String gCode;
  const Formkib(this.gCode, {Key key}) : super(key: key);
  //const Formkib(this.code);
  @override
  State<Formkib> createState() => _FormkibState();
}

class _FormkibState extends State<Formkib> {
  List<Map<String, dynamic>> dataKib = [
    {"kib": "KIB A", "kode": "1.3.1"},
    {"kib": "KIB B", "kode": "1.3.2"},
    {"kib": "KIB C", "kode": "1.3.3"},
    {"kib": "KIB D", "kode": "1.3.4"},
    {"kib": "KIB E", "kode": "1.3.5"},
    {"kib": "KIB F", "kode": "1.3.6"},
  ];

  String apiKey =
      "ad187474fbd0ce2e6e7281955659717f4cad3592e83cff7dbd8fe93888763c41";
  String idProv;
  String kdAset;
  String kdRincianObjek;
  String kdSubRincianObjek;
  String kdSubSubRincianObjek;
  String kdKib = "1.3.2";

  String kdSubUnit;
  String kdUpb;
  String idt;
  String kode_bar = '00001';

  // String base_url = "http://192.168.1.9/api";
  String selectedRincianObjek = '';
  List<String> dataRincianObjek = [];

  Future getRincianObjek(kode) async {
    var response = await http.get(
        Uri.parse(
            "https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataRincianObjek = jsonData;
    });
    return 'success';
  }

  Future getObjek(tableName, kode) async {
    var response = await http.get(
        Uri.parse("$BASE_URL/getObjek.php?tableName=$tableName&kode=$kode"));
    if (response.statusCode != 200) {
      return [];
    }
    List allObjek =
        (json.decode(response.body) as Map<String, dynamic>)["value"];
    List<Objek> allModelObjek = [];
    allObjek.forEach((element) {
      allModelObjek.add(Objek(
          idt: element["IDT"],
          kdAset: element["Kd_Aset"],
          nmAset: element["Nm_Aset"]));
    });
    return allModelObjek;
  }

  Future getUnit(tableName, kode) async {
    var response = await http.get(
        Uri.parse("$BASE_URL/getUnit.php?tableName=$tableName&kode=$kode"));
    if (response.statusCode != 200) {
      return [];
    }
    List allUnit =
        (json.decode(response.body) as Map<String, dynamic>)["value"];
    List<Unit> allModelUnit = [];
    allUnit.forEach((element) {
      allModelUnit.add(
          Unit(kodeUnit: element["kode_unit"], namaUnit: element["nama_unit"]));
    });
    return allModelUnit;
  }

  Future getBarang(kodeUpb, kodeAset) async {
    var response = await http.get(Uri.parse(
        "$BASE_URL/getBarang.php?kodeUpb=$kodeUpb&kodeAset=$kodeAset"));
    if (response.statusCode != 200) {
      return [];
    }
    List allBarang =
        (json.decode(response.body) as Map<String, dynamic>)["value"];
    List<Barang> allModelBarang = [];
    allBarang.forEach((element) {
      allModelBarang.add(Barang(
          idt: element["IDT"],
          referensi: element["Referensi"],
          refGroup: element["Ref_Group"],
          refMutasi: element["Ref_Mutasi"],
          refUsulan: element["Ref_Usulan"],
          refHistory: element["Ref_History"],
          refUsulanHis: element["Ref_Usulan_His"],
          kdUpb: element["Kd_UPB"],
          kdAset: element["Kd_Aset"],
          kdAset108: element["Kd_Aset_108"],
          kdRuang: element["Kd_Ruang"],
          noRegister: element["No_Register"],
          noPengadaan: element["No_Pengadaan"],
          refTemp: element["Ref_Temp"],
          nmAset: element["Nm_Aset"],
          kdPemilik: element["Kd_Pemilik"],
          tglPerolehan: element["Tgl_Perolehan"],
          tglMutasi: element["Tgl_Mutasi"],
          tglMulai: element["Tgl_Mulai"],
          tahun: element["Tahun"],
          luasM2: element["Luas_M2"],
          alamat: element["Alamat"],
          hakTanah: element["Hak_Tanah"],
          sertifikat: element["Sertifikat"],
          sertifikatTanggal: element["Sertifikat_Tanggal"],
          sertifikatNomor: element["Sertifikat_Nomor"],
          penggunaan: element["Penggunaan"],
          asalUsul: element["Asal_Usul"],
          harga: element["Harga"],
          noSp2D: element["No_SP2D"],
          merk: element["Merk"],
          type: element["Type"],
          ukuranCc: element["Ukuran_CC"],
          bahan: element["Bahan"],
          nomorPabrik: element["Nomor_Pabrik"],
          nomorRangka: element["Nomor_Rangka"],
          nomorMesin: element["Nomor_Mesin"],
          nomorPolisi: element["Nomor_Polisi"],
          nomorPolisiLama: element["Nomor_Polisi_Lama"],
          nomorBpkb: element["Nomor_BPKB"],
          pemegang: element["Pemegang"],
          pemegangLama: element["Pemegang_Lama"],
          kondisi: element["Kondisi"],
          masaManfaat: element["Masa_Manfaat"],
          nilaiAkhir: element["Nilai_Akhir"],
          bertingkat: element["Bertingkat"],
          beton: element["Beton"],
          luasLantai: element["Luas_Lantai"],
          lokasi: element["Lokasi"]));
    });
    return allModelBarang;
  }

  Future simpan() async {
    print('======SIMPAN======');
    print(idt + ' : ' + kdUpb + ' : ' + kdAset + ' : ' + kode_bar);

    var response = await post(Uri.parse("$BASE_URL/update_tabel_kib.php"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          "idt": idt,
          "Kd_UPB": kdUpb,
          "Kd_Aset_108": kdAset,
          "kode_bar": widget.gCode,
        },
        encoding: Encoding.getByName("utf-8"));

    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      Fluttertoast.showToast(
        msg: 'Sukses update data',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => insertTableFromQr(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: data.toString(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapping Data KIB"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          //UNIT
          DropdownSearch<Unit>(
            mode: Mode.MENU,
            showSearchBox: true,
            onChanged: (value) {
              kdSubUnit = value?.kodeUnit;
              print('==========');
              print(widget.gCode);
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.namaUnit ?? "Belum dipilih Unit"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.namaUnit),
            ),
            onFind: (text) async => await getUnit("ref_unit", "0.0.0"),
          ),

          SizedBox(
            height: 10,
          ),

          //SUB UNIT
          DropdownSearch<Unit>(
            mode: Mode.MENU,
            showSearchBox: true,
            onChanged: (value) {
              kdUpb = value?.kodeUnit;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.namaUnit ?? "Belum dipilih Sub Unit"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.namaUnit),
            ),
            onFind: (text) async => await getUnit("ref_sub_unit", kdSubUnit),
          ),

          SizedBox(
            height: 10,
          ),

          //UPB
          DropdownSearch<Unit>(
            mode: Mode.MENU,
            showSearchBox: true,
            onChanged: (value) {
              kdUpb = value?.kodeUnit;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.namaUnit ?? "Belum dipilih UPB"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.namaUnit),
            ),
            onFind: (text) async => await getUnit("ref_upb", kdUpb),
          ),

          SizedBox(
            height: 20,
          ),

          //PILIH KIB
          DropdownSearch<Map<String, dynamic>>(
            mode: Mode.MENU,
            dropdownSearchDecoration: InputDecoration(
              labelText: "Menu KIB",
              hintText: "Silahkan Pilih KIB",
            ),
            //showSearchBox: true,
            //showClearButton: true,
            items: dataKib,
            onChanged: (value) {
              print(value["kode"] ?? null);
              kdKib = value["kode"];
            },
            //onChanged: (value) => kdKib = value?.["kode"],
            //onChanged: kdKib = value?.["kode"],
            selectedItem: {
              "kib": "KIB B",
              "kode": "1.3.2",
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem["kib"].toString() ?? "Belum pilih KIB"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
                textColor: Colors.red, title: Text(item["kib"].toString())),
          ),
          SizedBox(
            height: 20,
          ),

          //OBJEK
          DropdownSearch<Objek>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            //onChanged: (value) => print(value?.toJson()),
            onChanged: (value) {
              kdRincianObjek = value?.kdAset;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.nmAset ?? "Belum dipilih Objek"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.nmAset),
            ),
            onFind: (text) async => await getObjek("ref_rek_aset108_4", kdKib),
          ),

          SizedBox(
            height: 10,
          ),
          //RINCIAN OBJEK
          DropdownSearch<Objek>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            onChanged: (value) {
              kdSubRincianObjek = value?.kdAset;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.nmAset ?? "Belum dipilih Rincian Objek"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.nmAset),
            ),
            onFind: (text) async =>
                await getObjek("ref_rek_aset108_5", kdRincianObjek),
          ),

          SizedBox(
            height: 10,
          ),
          //SUB RINCIAN OBJEK
          DropdownSearch<Objek>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            onChanged: (value) {
              kdSubSubRincianObjek = value?.kdAset;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.nmAset ?? "Belum dipilih Sub Rincian"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.nmAset),
            ),
            onFind: (text) async =>
                await getObjek("ref_rek_aset108_6", kdSubRincianObjek),
          ),

          SizedBox(
            height: 10,
          ),
          //SUB SUB RINCIAN OBJEK
          DropdownSearch<Objek>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            onChanged: (value) {
              kdAset = value?.kdAset;
            },
            dropdownBuilder: (context, selectedItem) =>
                Text(selectedItem?.nmAset ?? "Belum dipilih Sub Sub Rincian"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: Text(item.nmAset),
            ),
            onFind: (text) async =>
                await getObjek("ref_rek_aset108_7", kdSubSubRincianObjek),
          ),

          SizedBox(
            height: 10,
          ),
          // BARANG
          DropdownSearch<Barang>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            onChanged: (value) {
              idt = value?.idt;
            },
            dropdownBuilder: (context, selectedItem) => kdKib == '1.3.1'
                ? Text(selectedItem?.nmAset ?? "Belum dipilih Barang")
                : kdKib == '1.3.2'
                    ? selectedItem?.merk == '-'
                        ? Text(selectedItem?.nmAset ?? "Belum dipilih Barang")
                        : Text(selectedItem?.merk ?? "Belum dipilih Barang")
                    : kdKib == '1.3.3'
                        ? Text(selectedItem?.nmAset ?? "Belum dipilih Barang")
                        : kdKib == '1.3.4'
                            ? Text(
                                selectedItem?.nmAset ?? "Belum dipilih Barang")
                            : kdKib == '1.3.5'
                                ? Text(selectedItem?.nmAset ??
                                    "Belum dipilih Barang")
                                : kdKib == '1.3.6'
                                    ? Text(selectedItem?.nmAset ??
                                        "Belum dipilih Barang")
                                    : Text(selectedItem?.merk ??
                                        "Belum dipilih Barang"),
            popupItemBuilder: (context, item, isSelected) => ListTile(
              title: kdKib == '1.3.1'
                  ? Text(item.nmAset)
                  : kdKib == '1.3.2'
                      ? item.merk == '-'
                          ? Text(item.nmAset)
                          : Text(item.merk)
                      : kdKib == '1.3.3'
                          ? Text(item.nmAset)
                          : kdKib == '1.3.4'
                              ? Text(item.nmAset)
                              : Text(item.nmAset),
              subtitle: kdKib == '1.3.1'
                  ? Text(item.luasM2)
                  : kdKib == '1.3.2'
                      ? item?.nomorPolisi == '-'
                          ? Text('Reg:' + item?.noRegister)
                          : item?.pemegang != ''
                              ? Text(item?.nomorPolisi +
                                  '\nReg:' +
                                  item?.noRegister +
                                  '\nPemegang : ' +
                                  item?.pemegang)
                              : Text(item?.nomorPolisi +
                                  '\nReg:' +
                                  item?.noRegister)
                      : kdKib == '1.3.3'
                          ? Text(item.luasLantai)
                          : kdKib == '1.3.4'
                              ? Text(item.lokasi)
                              : kdKib == '1.3.5'
                                  ? Text('Tahun ' + item.tahun)
                                  : kdKib == '1.3.6'
                                      ? Text(item.lokasi)
                                      : Text(item.lokasi),
              trailing: Text(
                  CurrencyFormat.convertToIdr(double.parse(item.harga), 0)),
            ),
            onFind: (text) async => await getBarang(kdUpb, kdAset),
          ),

          const SizedBox(
            height: 10,
          ),
          //BUTTON SIMPAN
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1C),
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1C1C1C).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
                child: GestureDetector(
              onTap: simpan,
              child: const Text(
                "SIMPAN",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
