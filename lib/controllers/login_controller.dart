import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
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
      // Get.defaultDialog(
      //     title: "Terjadi kesalahan",
      //     middleText: "User Name dan Password salah.");
      DInfo.dialogError(Get.context, "User Name atau Password salah");
      DInfo.closeDialog(Get.context);
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

      // if (data.toString() == "Success") {
      if (data["message"] == "Success") {
        var userIid = data["value"]["User_ID"];
        var kode = data["value"]["Kode"];
        var fullName = data["value"]["Full_Name"];
        var shortName = data["value"]["Short_Name"];
        var level = data["value"]["Level"];
        var admin = data["value"]["Admin"];
        var active = data["value"]["Active"];
        var readonly = data["value"]["Readonly"];
        var nmUnit = data["value"]["Nm_Unit"];
        var nmSub = data["value"]["Nm_Sub"];
        var nmUpb = data["value"]["Nm_UPB"];

        addStringToSF(usernameC.text, "OK", userIid, kode, fullName, shortName,
            level, admin, active, readonly, nmUnit, nmSub, nmUpb);

        if (data["value"]["Active"] == 'N') {
<<<<<<< HEAD
=======
          // Get.defaultDialog(
          //     title: "Pemberitahuan", middleText: "Username tidak aktif");
>>>>>>> c40df348a0648ea6dfe3f989162e08a2f7e08f48
          DInfo.dialogError(Get.context, "Username tidak aktif");
          DInfo.closeDialog(Get.context);
        } else {
          Get.offAll(insertTableFromQr());
        }
      } else {
<<<<<<< HEAD
=======
        // Get.defaultDialog(
        //     title: "Terjadi kesalahan",
        //     middleText: "Username and password invalid");
>>>>>>> c40df348a0648ea6dfe3f989162e08a2f7e08f48
        DInfo.dialogError(Get.context, "Username and password belum benar");
        DInfo.closeDialog(Get.context);
      }
      //------------
    } catch (e) {
      // Get.defaultDialog(
      //     title: "Terjadi kesalahan",
      //     middleText: "Tidak dapat terkoneksi dengan server");
<<<<<<< HEAD
=======
      DInfo.dialogError(Get.context, "Tidak dapat terkoneksi dengan server");
      DInfo.closeDialog(Get.context);
>>>>>>> c40df348a0648ea6dfe3f989162e08a2f7e08f48
    }
  }

  void addStringToSF(
      String userName,
      String isLogin,
      String userIid,
      String kode,
      String fullName,
      String shortName,
      String level,
      String admin,
      String active,
      String readonly,
      String nmUnit,
      String nmSub,
      String nmUpb) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
    prefs.setString("isLogin", isLogin);
    prefs.setString("userIid", userIid);
    prefs.setString("kodeUpb", kode);
    prefs.setString("fullName", fullName);
    prefs.setString("shortName", shortName);
    prefs.setString("level", level);
    prefs.setString("admin", admin);
    prefs.setString("active", active);
    prefs.setString("readonly", readonly);
    prefs.setString("nmUnit", nmUnit);
    prefs.setString("nmSub", nmSub);
    prefs.setString("nmUpb", nmUpb);
  }
}
