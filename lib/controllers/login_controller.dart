import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../home.dart';

class LoginController extends GetxController {
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  void login0() async {
    if (usernameC.text == "" && passwordC.text == "") {
      Get.offAll(insertTableFromQr());
    } else {
      Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "User Name dan Password salah.");
    }
  }

  void login() async {
    isLoading.value = true;
    try {
      //------------
      var response = await post(Uri.parse("$BASE_URL/login_kib.php"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            "username": usernameC.text,
            "password": passwordC.text,
          },
          encoding: Encoding.getByName("utf-8"));

      var data = json.decode(response.body);
      isLoading.value = false;
      if (data.toString() == "Success") {
        addStringToSF(usernameC.text, "OK");

        Fluttertoast.showToast(
          msg: 'Login Successful',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );

        Get.offAll(insertTableFromQr());
      } else {
        Get.defaultDialog(
            title: "Terjadi kesalahan",
            middleText: "Username and password invalid");
      }
      //------------

    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Tidak dapat terkoneksi dengan server");
    }
  }

  void addStringToSF(String userName, String isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
    prefs.setString("isLogin", isLogin);
  }
}
