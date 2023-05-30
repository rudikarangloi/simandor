import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simandoronline/controllers/login_controller.dart';
import 'constants.dart';
import 'home.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final LoginController loginC = Get.put(LoginController());

  TextEditingController user = TextEditingController();

  TextEditingController pass = TextEditingController();

  Future login() async {
    // var url2 = Uri.http("192.168.1.9", '/api/login_kib.php', {'q': '{http}'});
    // var response2 = await http.post(url2, body: {
    //   "username": user.text,
    //   "password": pass.text,
    // });

    var response = await post(Uri.parse("$BASE_URL/login_kib.php"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: {
          "username": user.text,
          "password": pass.text,
        },
        encoding: Encoding.getByName("utf-8"));

    var data = json.decode(response.body);

    if (data.toString() == "Success") {
      // if (data["message"] == "Success") {
      //print(data["value"]);
      //addStringToSF(user.text, "OK");

      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => insertTableFromQr(),
      //   ),
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => insertTableFromQr(),
      //   ),
      // );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void addStringToSF(String userName, String isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
    prefs.setString("isLogin", isLogin);

    //var nik = prefs.getString('nik');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Aplikasi",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1C1C1C),
            height: 2,
          ),
        ),
        const Text(
          "SIMANDOR ONLINE",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1C),
            letterSpacing: 2,
            height: 1,
          ),
        ),
        const Text(
          "Kabupaten Balangan",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1C1C1C),
            height: 1,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          // controller: user,
          controller: loginC.usernameC,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.black,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Obx(() => TextField(
              controller: loginC.passwordC,
              obscureText: loginC.isHidden.value,
              style: const TextStyle(color: Colors.white),
              // controller: pass,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => loginC.isHidden.toggle(),
                  icon: Icon(Icons.remove_red_eye),
                ),
                hintText: 'Password',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.black,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            )),
        const SizedBox(
          height: 24,
        ),
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
          child: Obx(() => Center(
                  child: GestureDetector(
                // onTap: () => loginC.login(),
                onTap: () {
                  if (loginC.isLoading.isFalse) {
                    loginC.login();
                  }
                },
                child: Text(
                  loginC.isLoading.isFalse ? "LOGIN" : "Loading ....",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ))),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: GestureDetector(
            onTap: () => viewer(),
            child: const Text(
              "View Barang..",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1C),
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void viewer() {
    Get.to(insertTableFromQr());
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => insertTableFromQr()));
  }
}
