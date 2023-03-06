import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simandoronline/constants.dart';
import 'package:simandoronline/models/barangDetail.dart';
import 'functions/currencyFormat.dart';
import 'models/barang.dart';
import 'models/ruangDetail.dart';
import 'models/unitDetail.dart';
import 'models/upbDetail.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final String code;

  const DetailPage({Key key, this.index, this.code}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _like = false;

  Barang barangDetail;
  UnitDetail unitDetail;
  UpbDetail upbDetail;
  RuangDetail ruangDetail;
  String mKode = "";
  String kodeUpb = "";
  String kodeUnit = "";
  String kodeRuang = "";

  String showUnit = '';
  String showUpb = '';
  String showRuang = '';
  String showMerk = '';
  String showNopol = '';
  String showNoRangka = '';
  String showPemegang = '';
  String showRegister = '';
  String showharga = '';
  String showNmAsset = '';
  String showNmBpkb = '';
  String kdAsset108 = '';
  String idt = '';
  String fileName = '';

  String fileImageName = '';
  var arrFileImageName = [];

  Future<Barang> getBarang() async {
    print('cek api : $BASE_URL/getBarangDetail.php?kode=${widget.code}');
    await http
        .get(Uri.parse("$BASE_URL/getBarangDetail.php?kode=${widget.code}"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          barangDetail = Barang.fromJson(jsonDecode(response.body));
          kodeUpb = barangDetail.kdUpb;
          kodeRuang = barangDetail.kdRuang;
          kodeUnit = kodeUpb.substring(0, 11);

          if (barangDetail.fileName.isNotEmpty) {
            //arrFileImageName = barangDetail.fileName.split('xyz');
            //fileImageName = arrFileImageName[1].toString();
            fileImageName = barangDetail.idt + 'xyz' + barangDetail.fileName;
            print("Arraynya 1 " + fileImageName);
          } else {
            print("Arraynya 2");
            fileImageName = 'noimage.jpg';
          }
          // print('kode UPB : ' + kodeUpb);
          // print('kode Ruang : ' + kodeRuang);
          // print('kode Unit : ' + kodeUnit);
          print('test filename : ' +
              barangDetail.fileName +
              ' --> ' +
              barangDetail.idt);
        });

        getUnitDetail(kodeUnit);
        getUpbDetail(kodeUpb);
        getRuangDetail(kodeUpb, kodeRuang);

        kdAsset108 = barangDetail.kdAset108;
        fileName = barangDetail.fileName;
        showNmAsset = barangDetail.nmAset + '\n';
        showNmBpkb = 'Nomor BPKB : ' + barangDetail.nomorBpkb + '\n';
        showMerk = barangDetail.merk == '-'
            ? ''
            : barangDetail.merk.isEmpty
                ? ''
                : 'Merk : ' + barangDetail.merk + '\n';
        showMerk = 'Merk : ' + barangDetail.merk + '\n';

        showNopol = barangDetail.nomorPolisi == '-'
            ? ''
            : barangDetail.nomorPolisi.isEmpty
                ? ''
                : 'Nomor Polisi : ' + barangDetail.nomorPolisi + '\n';
        showNopol = 'Nomor Polisi : ' + barangDetail.nomorPolisi + '\n';
        showNoRangka = 'Nomor Rangka : ' + barangDetail.nomorRangka + '\n';

        showPemegang = barangDetail.pemegang == '-'
            ? ''
            : barangDetail.pemegang.isEmpty
                ? ''
                : 'Pemegang Barang : ' + barangDetail.pemegang + '\n';
        showPemegang = 'Pemegang Barang : ' + barangDetail.pemegang + '\n';

        showRegister = 'Nomor Register : ' + barangDetail.noRegister + '\n';

        showharga =
            CurrencyFormat.convertToIdr(double.parse(barangDetail.harga), 0);
      }
    });
    return barangDetail;
  }

  Future<UnitDetail> getUnitDetail(kode) async {
    await http
        .get(Uri.parse("$BASE_URL/getUnitDetail.php?kode=$kode"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          unitDetail = UnitDetail.fromJson(jsonDecode(response.body));
          showUnit = '' + unitDetail.nmUnit + '\n';
        });
      }
    });
    return unitDetail;
  }

  Future<UpbDetail> getUpbDetail(kode) async {
    await http
        .get(Uri.parse("$BASE_URL/getUpbDetail.php?kode=$kode"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          upbDetail = UpbDetail.fromJson(jsonDecode(response.body));
          showUpb = '' + upbDetail.nmUpb + '\n';
        });
      }
    });
    return upbDetail;
  }

  Future<RuangDetail> getRuangDetail(kodeUpb, kodeRuang) async {
    await http
        .get(Uri.parse(
            "$BASE_URL/getRuangDetail.php?kodeUpb=$kodeUpb&kodeRuang=$kodeRuang"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          ruangDetail = RuangDetail.fromJson(jsonDecode(response.body));

          showRuang = ruangDetail.nmRuang.isEmpty
              ? ''
              : '' + ruangDetail.nmRuang + '\n';
        });
      }
    });
    return ruangDetail;
  }

  showDialogFunc(context, img, title, desc) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              height: 310,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 212,
                    //color: Colors.black38,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                          '$BASE_URL_IMAGES_SIMANDOR/$fileImageName'),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    // width: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        barangDetail.nmAset,
                        maxLines: 3,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getBarang();
    setState(() {
      mKode = widget.code;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                height: height * 0.55,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        //image: Image.asset('name'),
                        image: NetworkImage(
                            '$BASE_URL_IMAGES/slideshow/image (3).jpg'),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.9),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                ),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.5),
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: unnecessary_brace_in_string_interps
                  children: <Widget>[
                    Text(
                      // ignore: null_aware_before_operator
                      showUnit + showUpb + showRuang,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    //Image.network('$BASE_URL_IMAGES/slideshow/image (2).jpg'),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 50,
                      width: width,
                      color: Colors.black45,
                      child: ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int key) {
                          return Icon(
                            Icons.arrow_circle_up,
                            color: Colors.yellow[900],
                            size: 34,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      showNmAsset.toUpperCase() +
                          showMerk +
                          showRegister +
                          showNopol +
                          showNoRangka +
                          showNmBpkb +
                          showPemegang,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      'MARI KITA JAGA DAN PELIHARA ASET INI',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Kode Barang : ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              kdAsset108,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialogFunc(context, 'barangDetail.idt',
                                'titleList', 'descList');
                          },
                          child: const Text(
                            "Photo",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: height * 0.05,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.keyboard_backspace,
                    size: 42,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 30,
                top: height * 0.45,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _like = !_like;
                    });
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 1)
                        ]),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 45,
                      color: (_like) ? Colors.red : Colors.grey[600],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
