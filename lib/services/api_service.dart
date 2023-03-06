import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../entities/insert_data_antrian_model.dart';

class ApiService {
  //static final _host = 'http://hafidzputra.com/server_inventory/index.php/api';

  //DB:Mysql Server
  Future<ResponseVerifyData> postInsertVerifyData(
      kodeBarang, verifikasiTanggal, otorisator) async {
    final response = await http
        .post(Uri.parse('$BASE_URL/add_verification_data.php'), body: {
      "kode_barang": kodeBarang,
      "verifikasi_status": "1",
      "verifikasi_tanggal": verifikasiTanggal,
      "otorisator": otorisator
    });

    if (response.statusCode == 200) {
      ResponseVerifyData responseRequest =
          ResponseVerifyData.fromJson(jsonDecode(response.body));
      return responseRequest;
    } else {
      return null;
    }
  }

  /*
  Future<ResponsePost> delBarang(id) async {

    final response = await http.post('$_host/deletebarang', body: {'id': id});

    if (response.statusCode == 200) {
      ResponsePost responseRequest =
          ResponsePost.fromJson(jsonDecode(response.body));

      return responseRequest;
    } else {
      return null;
    }
  }

   */
}
