import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simandoronline/formkib.dart';
import 'package:simandoronline/models/barang.dart';
import 'constants.dart';
import 'formkib_lite.dart';
import 'tesDetail.dart';

class Detail extends StatefulWidget {
  final String code;
  //const Detail(Key key, this.code) : super(key: key);
  const Detail(this.code);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Barang barang;
  String mKode = "";
  bool login = false;
  String isLogin = "";

  Future<Barang> getBarang() async {
    await http
        .get(Uri.parse("$BASE_URL/getBarangDetail.php?kode=${widget.code}"))
        .then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          barang = Barang.fromJson(jsonDecode(response.body));
        });
      }
    });
    return barang;
  }

  void getStringSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.get('isLogin');

    if (isLogin == "OK") {
      setState(() {
        login = true;
      });
    }

    print('check : $isLogin : $login');
  }

  @override
  void initState() {
    getBarang();
    getStringSF();
    setState(() {
      mKode = widget.code;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Barang>(
            future: getBarang(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DetailPage(
                  index: 1,
                  code: widget.code,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.data == null) {
                if (login == true) {
                  //return Formkib(mKode);
                  return Formkiblite(mKode);
                } else {
                  return const Text('Data tidak ditemukan');
                }
              }

              return const CircularProgressIndicator();
            }),
      ),
    );

    // barang == null
    //     ? mKode == '-1'
    //         ? Navigator.pop(context)
    //         : Formkib(mKode)
    //     : DetailPage(
    //         index: 1,
    //         code: widget.code,
    //       );
  }

  void showMessage(BuildContext context, String dTitle, String dMessage) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context, rootNavigator: false).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //backgroundColor: Colors.blue,
      title: Text(dTitle),
      content: Text(dMessage),
      actions: [
        okButton,
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
}
