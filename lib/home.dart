import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'detail.dart';
import 'formlogin.dart';
import 'main.dart';
import 'models/barang.dart';

class insertTableFromQr extends StatefulWidget {
  @override
  _insertTableFromQrState createState() => _insertTableFromQrState();
}

class _insertTableFromQrState extends State<insertTableFromQr> {
  String code = "";
  String getCode = "";
  String isLogin = "";
  bool login = false;
  Barang barang;
  String userName;

  void getStringSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.get('isLogin');

    //print("Chek is login : " + isLogin);
    if (isLogin == "OK") {
      setState(() {
        login = true;
      });
    }

    //print("Chek loginku : " + login.toString());
  }

  Future cekUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.get('userName');
    //print("Usename : " + userName);
  }

  @override
  void initState() {
    getStringSF();
    super.initState();
  }

  getBarang(fCode) {
    http
        .get(Uri.parse("$BASE_URL/getBarangDetail.php?kode=$fCode"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          barang = Barang.fromJson(jsonDecode(response.body));
        });
      }
    });
    return barang;
  }

  Future scanbarcode() async {
    //await FlutterBarcodeScanner.scanBarcode(lineColor, cancelButtonText, isShowFlashIcon, scanMode)
    await FlutterBarcodeScanner.scanBarcode(
            "#009922", "Batal", false, ScanMode.QR)
        .then((String kode) {
      if (kode != "-1") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Detail(kode)));
        // getBarang(kode);
        // if (barang != null) {
        //   print('check : Barangnya ada');
        // } else {
        //   if (login == true) {
        //     print('check : barang laka dan buka KIB');
        //   } else {
        //     print('check : barang laka dan Tampilkan pesan');
        //   }
        // }
      }
    });
  }

  void setStringSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", "");
    prefs.setString("isLogin", "");
  }

  void confirmExit(BuildContext context, String dTitle, String dMessage) {
    Widget cancelButton = ElevatedButton(
      child: Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () async {
        exit(0);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dTitle),
      content: Text(dMessage),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void confirmLogout(BuildContext context, String dTitle, String dMessage) {
    Widget cancelButton = ElevatedButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        setStringSF();
        Get.offAll(const FormLogin());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) {
        //     return MyApp();
        //   }),
        // );
        //exit(0);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dTitle),
      content: Text(dMessage),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          child: const Icon(Icons.logout_outlined),
          onPressed: () {
            login
                ? confirmLogout(
                    context, "Perhatian ", "Log Out dari Aplikasi ?")
                : Get.off(MyApp());
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (context) {
            //       return MyApp();
            //     }),
            //   );
          },
          heroTag: null,
        )
      ]),
      //backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        title: const Text("SCAN KODE BARANG"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                "MULAI",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                scanbarcode();
              },
            ),
          ],
        ),
      ),
    );
  }
}
