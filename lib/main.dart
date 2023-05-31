import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simandoronline/formkib_lite.dart';

import 'detail.dart';
import 'formkib.dart';
import 'formlogin.dart';
import 'home.dart';
import 'test/DataTableDemo.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool login = false;

  String isLogin = "";

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

  @override
  void initState() {
    getStringSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIMANDOR',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: insertTableFromQr(),
        //home: FormLogin(),
        //home: const Formkib("02"),
        home: const Formkiblite("02")
        //home: login == true ? insertTableFromQr() : const FormLogin(),
        //home: const Detail('KIB-B-0000000004')
        // home: DetailPage(
        //   index: 1,
        // )
        //home: DataTableDemo()
        );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
