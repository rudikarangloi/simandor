import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormKibController extends GetxController {
  RxBool isTampilUnit = false.obs;
  RxBool isTampilSubUnit = false.obs;
  RxBool isTampilUpb = false.obs;

  RxBool isTampilStringUnit = false.obs;
  RxBool isTampilStringSubUnit = false.obs;
  RxBool isTampilStringUpb = false.obs;

  RxString level = ''.obs;
  RxString admin = ''.obs;
  RxString readonly = ''.obs;
  RxString kodeUpb = ''.obs;
  RxString nmUnit = ''.obs;
  RxString nmSub = ''.obs;
  RxString nmUpb = ''.obs;

  String kdUnit;
  String kdSubUnit;
  String kdUpb;

  void getStringSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // level.value = prefs.get('level');
    level.value = '3';
    admin.value = prefs.get('admin');
    readonly.value = prefs.get('readonly');
    kodeUpb.value = prefs.get('kodeUpb');
    nmUnit.value = prefs.get('nmUnit');
    nmSub.value = prefs.get('nmSub');
    nmUpb.value = prefs.get('kodeUpb');

    // kodeUpb 	= 24.04.04.01.01.001
    // kd_unit 	= 24.04.01.01			    / 11 huruf
    // kd_sub_unit = 24.04.01.01.01		/ 14 huruf

    kdUnit = kodeUpb.value.substring(0, 11);
    kdSubUnit = kodeUpb.value.substring(0, 14);
    kdUpb = kodeUpb.value;

    if ((level.value == '0') || (level.value == '1') || (level.value == '2')) {
      isTampilUnit.value = true;
    }
    if ((level.value == '0') ||
        (level.value == '1') ||
        (level.value == '2') ||
        (level.value == '3')) {
      isTampilSubUnit.value = true;
    }
    if ((level.value == '0') ||
        (level.value == '1') ||
        (level.value == '2') ||
        (level.value == '3') ||
        (level.value == '4')) {
      isTampilUpb.value = true;
    }
    if ((level.value == '3') || (level.value == '4')) {
      isTampilStringUnit.value = true;
    }
    if ((level.value == '4')) {
      isTampilStringSubUnit.value = true;
    }

    print("kodeUpb :" + kodeUpb.value);
    print("nmUnit :" + nmUnit.value);
    print("nmSub :" + nmSub.value);
    print("nmUpb :" + nmUpb.value);
    print("Level :" + level.value);
    print("tampil Unit :" + isTampilUnit.value.toString());
    print("tampil Sub Unit :" + isTampilSubUnit.value.toString());
    print("tampil UPB :" + isTampilUpb.value.toString());
    print("tampil Tampil String Unit :" + isTampilStringUnit.value.toString());
    print("tampil Tampil String Sub Unit :" +
        isTampilStringSubUnit.value.toString());
    print("tampil UPB :" + isTampilUpb.value.toString());
    print("kode Unit :" + kdUnit.toString());
    print("kode sub unit :" + kdSubUnit.toString());
    print("kode UPB :" + kdUpb.toString());
  }

  @override
  void onInit() {
    getStringSF();
    super.onInit();
  }
}
