import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'constants.dart';

class FormInputDataBarang extends StatefulWidget {
  @override
  _FormInputDataBarangState createState() => _FormInputDataBarangState();
}

class _FormInputDataBarangState extends State<FormInputDataBarang> {
  String _nik = "";
  String _nama = "";
  final String _namaIbu = "";
  final String _tempatLahir = "";
  final String _tanggallahir = "";
  String _alamat = "";
  final String _alamatKtp = "";
  String _nomorTelepon = "";
  String _statesIsomanOrVaksin = "";
  List<String> agama = [
    "Islam",
    "Katolik",
    "Protestan",
    "Budha",
    "Hindu",
    "Konghucu"
  ];
  final String _agama = "Islam";
  String _keluhan = "";
  final String _notelp = "";
  Position _currentPosition2;

  //-------------------
  String selectedKabupaten;
  List dataKabupaten = [];

  String selectedObjek;
  List dataObjek = [];

  String selectedRincianObjek = '';
  List dataRincianObjek = [];

  String selectedSubRincianObjek;
  List dataSubRincianObjek = [];

  String selectedSubSubRincianObjek;
  List dataSubSubRincianObjek = [];

  String selectedUnit;
  List dataUnit = [];

  String selectedSubUnit;
  List dataSubUnit = [];

  String selectedUpb;
  List dataUpb = [];

  String selectedRuang;
  List dataRuang = [];

  File _image;
  String isImage;
  final picker = ImagePicker();

  // Future choiceImage()async{
  //   var pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedImage.path);
  //     isImage = '1';
  //   });
  // }

  Future getObjek() async {
    var response = await http.get(
        Uri.parse('http://192.168.1.9/api/getObjek.php'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataObjek = jsonData;
    });
    print('$BASE_URL/getObjek.php');
    return 'success';
  }

  Future getKabupaten() async {
    var response = await http.get(
        Uri.parse('http://192.168.1.9/api_simpus/getKabupaten.php'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataKabupaten = jsonData;
    });
    print(jsonData);
    return 'success';
  }

  Future getRincianObjek(kode) async {
    var response = await http.get(
        Uri.parse('$BASE_URL/getRincianObjek.php?id=$kode'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataRincianObjek = jsonData;
    });
    return 'success';
  }

  Future getSubRincianObjek(kode) async {
    var response = await http.get(
        Uri.parse('$BASE_URL/getSubRincianObjek.php?id=$kode'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataSubRincianObjek = jsonData;
    });
    return 'success';
  }

  Future getSubSubRincianObjek(kode) async {
    var response = await http.get(
        Uri.parse('$BASE_URL/getSubSubRincianObjek.php?id=$kode'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataSubSubRincianObjek = jsonData;
    });
    return 'success';
  }

  Future getUnit() async {
    var response = await http.get(Uri.parse('$BASE_URL/getUnit.php'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataUnit = jsonData;
    });
    return 'success';
  }

  Future getSubUnit(kode) async {
    var response = await http.get(
        Uri.parse('$BASE_URL/getSubUnit.php?id=$kode'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataSubUnit = jsonData;
    });
    return 'success';
  }

  Future getUpb(kode) async {
    var response = await http.get(Uri.parse('$BASE_URL/getUpb.php?id=$kode'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataUpb = jsonData;
    });
    return 'success';
  }

  Future getRuang(kode) async {
    var response = await http.get(Uri.parse('$BASE_URL/getRuang.php?id=$kode'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      dataRuang = jsonData;
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    //getObjek();
    getKabupaten();
    _statesIsomanOrVaksin = "1";
    isImage = '0';
  }

  //-----------------------

  DateTime _currentdate = DateTime.now();
  Future<void> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(1930),
        lastDate: DateTime(2030),
        //initialDatePickerMode: DatePickerMode.year,
        //Hari sabtu dan minggu tidak bis dipilih
        //selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7?false:true,
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null) {
      setState(() {
        _currentdate = _seldate;
        _controllerTanggalLahir.text = _seldate.day.toString() +
            '/' +
            _seldate.month.toString() +
            '/' +
            _seldate.year.toString();
      });
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition2 = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _pilihIsomanOrVaksin(String valued) {
    setState(() {
      _statesIsomanOrVaksin = valued;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controllerTanggalLahir = TextEditingController(text: '');

  Widget _buildNik() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'NIK',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      keyboardType: TextInputType.number,
      //maxLength: 16,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Harus diisi';
        }
        return null;
      },
      onSaved: (String value) {
        _nik = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Nama',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      //maxLength: 50,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Harus di isi';
        }
        return null;
      },
      onSaved: (String value) {
        _nama = value;
      },
    );
  }

  Widget _buildAlamat() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Alamat lengkap',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      //maxLength: 100,
      maxLines: 2,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Harus di isi';
        }
        return null;
      },
      onSaved: (String value) {
        _alamat = value;
      },
    );
  }

  Widget _buildKeluhan() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Keluhan',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      //maxLength: 100,
      maxLines: 2,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Harus di isi';
        }
        return null;
      },
      onSaved: (String value) {
        _keluhan = value;
      },
    );
  }

  Widget _buildKabupaten() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Text("Kabupaten : " ,style: TextStyle(fontSize: 18),),SizedBox(width: 25),
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.black12,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectedKabupaten,
              hint: const Text('Pilih Kabupaten'),
              items: dataKabupaten.map((list) {
                return DropdownMenuItem(
                  //child: Text(list['deskripsi']),
                  child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                  value: list['kode'].toString(),
                );
              }).toList(),
              onChanged: (value) {
                selectedKabupaten = value;
                // selectedKecamatan = null;
                // selectedDesa = null;
                // selectedPuskesmas = null;
                //dataKecamatan.clear();
                //getKecamatan(value);
                //setState(() {
                //  selectedName = value;
                //});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildObjek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Text("Kabupaten : " ,style: TextStyle(fontSize: 18),),SizedBox(width: 25),
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.black12,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectedObjek,
              hint: const Text('Pilih Objek'),
              items: dataObjek.map((list) {
                return DropdownMenuItem(
                  //child: Text(list['deskripsi']),
                  child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                  value: list['kode'].toString(),
                );
              }).toList(),
              onChanged: (value) {
                selectedObjek = value;
                selectedRincianObjek = null;
                selectedSubRincianObjek = null;
                selectedSubSubRincianObjek = null;
                //dataKecamatan.clear();
                getRincianObjek(value);
                //setState(() {
                //  selectedName = value;
                //});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRincianObjek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.yellowAccent,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            value: selectedRincianObjek,
            hint: const Text('Pilih Rincian Objek'),
            items: dataRincianObjek.map((list) {
              return DropdownMenuItem(
                //child: Text(list['deskripsi']),
                child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                value: list['kode'].toString(),
              );
            }).toList(),
            onChanged: (value) {
              selectedRincianObjek = value;
              selectedSubRincianObjek = null;
              selectedSubSubRincianObjek = null;
              getSubRincianObjek(value);
              getSubSubRincianObjek(value);
              print(' kode kecamatan : ' + value);
            },
          )),
        ),
      ],
    );
  }

  Widget _buildSubRincianObjek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.yellowAccent,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            value: selectedSubRincianObjek,
            hint: const Text('Pilih Sub Rincian Objek'),
            items: dataSubRincianObjek.map((list) {
              return DropdownMenuItem(
                child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                value: list['kode'].toString(),
              );
            }).toList(),
            onChanged: (value) {
              selectedSubRincianObjek = value;
              _pilihIsomanOrVaksin(_statesIsomanOrVaksin);
              print(' kode Kelurahan/Desa : ' + value);
            },
          )),
        ),
      ],
    );
  }

  Widget _buildKSubSubRincianObjek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.black12,
              border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            //isExpanded: true,
            value: selectedSubSubRincianObjek,
            hint: const Text('Pilih Sub Sub Rincian Objek'),

            items: dataSubSubRincianObjek.map((list) {
              return DropdownMenuItem(
                child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                value: list['kode'].toString(),
              );
            }).toList(),

            onChanged: (value) {
              selectedSubSubRincianObjek = value;
              _pilihIsomanOrVaksin(_statesIsomanOrVaksin);
            },
          )),
        ),
      ],
    );
  }

  Widget _buildNamaBarang() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Nama barang',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      //maxLength: 16,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Harus diisi';
        }
        return null;
      },
      onSaved: (String value) {
        _nomorTelepon = value;
      },
    );
  }

  Widget _buildUnit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selectedUnit,
              hint: const Text('Pilih Unit'),
              items: dataUnit.map((list) {
                return DropdownMenuItem(
                  child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                  value: list['kode'].toString(),
                );
              }).toList(),
              onChanged: (value) {
                selectedUnit = value;
                selectedSubUnit = null;
                selectedUpb = null;
                selectedRuang = null;
                getSubUnit(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubUnit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            value: selectedSubUnit,
            hint: const Text('Pilih Sub Unit'),
            items: dataSubUnit.map((list) {
              return DropdownMenuItem(
                child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                value: list['kode'].toString(),
              );
            }).toList(),
            onChanged: (value) {
              selectedSubUnit = value;
              selectedUpb = null;
              selectedRuang = null;
              getUpb(value);
            },
          )),
        ),
      ],
    );
  }

  Widget _buildUpb() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            value: selectedUpb,
            hint: const Text('Pilih UPB'),
            items: dataUpb.map((list) {
              return DropdownMenuItem(
                child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                value: list['kode'].toString(),
              );
            }).toList(),
            onChanged: (value) {
              selectedUpb = value;
              selectedRuang = null;
              getRuang(value);
            },
          )),
        ),
      ],
    );
  }

  Widget _buildKRuang() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25.0, right: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            //isExpanded: true,
            value: selectedRuang,
            hint: const Text('Pilih Ruang'),

            items: dataRuang.map((list) {
              return DropdownMenuItem(
                child: SizedBox(width: 240.0, child: Text(list['deskripsi'])),
                value: list['kode'].toString(),
              );
            }).toList(),

            onChanged: (value) {
              selectedRuang = value;
            },
          )),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          child: const Text(
            'Simpan',
            style: TextStyle(color: Colors.deepPurple, fontSize: 16),
          ),
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              showMessage(context, "Perhatian", "Mohon lengkapi data.");
              return;
            }
            if (selectedObjek == null) {
              showMessage(context, "Perhatian. ", "Kabupaten belum dipilih ");
            } else if (selectedRincianObjek == null) {
              showMessage(context, "Perhatian. ", "Kecamatan belum dipilih ");
            } else if (selectedSubRincianObjek == null) {
              showMessage(
                  context, "Perhatian. ", "Kelurahan/desa belum dipilih ");
            } else if (selectedSubSubRincianObjek == null) {
              showMessage(context, "Perhatian. ", "Puskesmas belum dipilih ");
            } else {
              _formKey.currentState.save();
              confirmMessage(
                  context,
                  "Data Pendaftaran Anda:",
                  "NIK : " +
                      _nik +
                      "\n" +
                      "Nama : " +
                      _nama +
                      "\n"
                          "Keluhan : " +
                      _keluhan +
                      "\n",
                  _nik,
                  _nama,
                  _namaIbu,
                  _tempatLahir,
                  _tanggallahir,
                  _alamat,
                  _nomorTelepon,
                  _agama,
                  _statesIsomanOrVaksin,
                  _alamatKtp,
                  _keluhan,
                  _currentPosition2,
                  selectedObjek,
                  selectedRincianObjek,
                  selectedSubRincianObjek,
                  selectedSubSubRincianObjek,
                  _statesIsomanOrVaksin);
            }
          },
        ),
        const SizedBox(width: 25),
        ElevatedButton(
            child: const Text(
              'Batal',
              style: TextStyle(color: Colors.deepPurple, fontSize: 16),
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }

  Widget _buildAs(str) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          str,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  Widget _buildUploadFile(str) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          str,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 25),
        IconButton(
          icon: const Icon(Icons.upload_file),
          onPressed: () {
            //choiceImage();
          },
        ),
      ],
    );
  }

  Widget _builstateIsomanOrVaksin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RadioListTile(
          value: '1',
          groupValue: _statesIsomanOrVaksin,
          onChanged: (String value) {
            _pilihIsomanOrVaksin(value);
          },
          activeColor: Colors.blueAccent,
          title: const Text("Isoman"),
        ),
        RadioListTile(
          value: '0',
          groupValue: _statesIsomanOrVaksin,
          onChanged: (String value) {
            _pilihIsomanOrVaksin(value);
          },
          activeColor: Colors.blueAccent,
          title: const Text("Vaksin"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return Scaffold(
      appBar: AppBar(title: const Text("Form Input Data Barang")),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text(
                    "Data Barang : ",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 3),
                  _buildKabupaten(),
                  //_buildObjek(),
                  // SizedBox(height: 3),
                  // _buildRincianObjek(),
                  // SizedBox(height: 3),
                  // _buildSubRincianObjek(),
                  // SizedBox(height: 3),
                  // _buildKSubSubRincianObjek(),
                  const SizedBox(
                    height: 3,
                  ),
                  _buildNamaBarang(),
                  const SizedBox(height: 3),
                  const SizedBox(height: 5),
                  const Text(
                    "Data Unit : ",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  _buildUnit(),
                  const SizedBox(height: 3),
                  _buildSubUnit(),
                  const SizedBox(height: 3),
                  _buildUpb(),
                  const SizedBox(height: 3),
                  _buildKRuang(),
                  _buildButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //----------------

  Future saveUploadImage(
      BuildContext context,
      nik,
      nama,
      namaIbu,
      tempatLahir,
      tanggalLahir,
      alamat,
      noTelp,
      agama,
      jenisKelamin,
      alamatKtp,
      keluhan,
      _currentPosition2,
      selectedKabupaten,
      selectedKecamatan,
      selectedDesa,
      selectedPuskesmas,
      _jenisKelamin) async {
    String strPosLat = '-';
    String strPosLng = '-';

    String msgAPI = "";

    if (_currentPosition2 != null) {
      strPosLat = "${_currentPosition2.latitude}";
      strPosLng = "${_currentPosition2.longitude}";
    }

    final url = Uri.parse("$BASE_URL/add_data_isoman.php");
    var requests = http.MultipartRequest('POST', url);
    //Kirim Post variabel/
    requests.fields['FS_KD_IDENTITAS'] = nik;
    requests.fields['FS_NM_PASIEN'] = nama;
    requests.fields['FS_ALM_PASIEN'] = alamat;
    requests.fields['FS_KELUHAN'] = keluhan;
    requests.fields['FS_POS_LAT'] = strPosLat;
    requests.fields['FS_POS_LNG'] = strPosLng;
    requests.fields['FS_KD_KAB'] = selectedKabupaten;
    requests.fields['FS_KD_KEC'] = selectedKecamatan;
    requests.fields['FS_KD_KEL'] = selectedDesa;
    requests.fields['FS_KD_PUS'] = selectedPuskesmas;
    requests.fields['FS_NO_TLP'] = noTelp;
    requests.fields['FS_KD_STATE'] = _jenisKelamin;
    //requests.fields['FS_IMAGE'] = _image;
    if (isImage == '1') {
      var pic = await http.MultipartFile.fromPath("image", _image.path);
      requests.files.add(pic);
    }

    var response = await requests.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
      //addStringToSF(nik,msgAPI,nama,alamat, tempatLahir, tanggalLahir,alamatKtp);
      showMessageAct(context, "Perhatian. ",
          "Silahkan menunggu, petugas akan segera merespon");
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     //return HomeScreen();
      //     return Landing();
      //   }),
      // );
    } else {
      print('Image Not Uploded');
      showMessage(context, "Perhatian. ", "Data gagal tersimpan. ");
    }
  }

  void saveForm(
      BuildContext context,
      nik,
      nama,
      namaIbu,
      tempatLahir,
      tanggalLahir,
      alamat,
      noTelp,
      agama,
      jenisKelamin,
      alamatKtp,
      keluhan,
      _currentPosition2,
      selectedKabupaten,
      selectedKecamatan,
      selectedDesa,
      selectedPuskesmas,
      _jenisKelamin) {
    String strPosLat = '-';
    String strPosLng = '-';

    if (_currentPosition2 != null) {
      strPosLat = "${_currentPosition2.latitude}";
      strPosLng = "${_currentPosition2.longitude}";
    }

    //Lakukan cek disini
    var url = BASE_URL + "add_data_isoman.php";

    String msgAPI = "";
    String FSKDIDENTITAS = nik;
    String FSNMPASIEN = nama;
    String FSKELUHAN = keluhan;
    String FSALMPASIEN = alamat;
    String FSKDKAB = selectedKabupaten;
    String FSKDKEC = selectedKecamatan;
    String FSKDKEL = selectedDesa;
    String FSPOSLAT = strPosLat;
    String FSPOSLNG = strPosLng;
    String FSNOTLP = noTelp;

    String FSKDPUS = selectedPuskesmas;
    String FSKDSTATE = _jenisKelamin;
    File FSIMAGE = _image;

    http.post(Uri.parse(url), body: {
      //Kirim Post variabel/
      "FS_KD_IDENTITAS": FSKDIDENTITAS,
      "FS_NM_PASIEN": FSNMPASIEN,
      "FS_ALM_PASIEN": FSALMPASIEN,
      "FS_KELUHAN": FSKELUHAN,
      "FS_POS_LAT": FSPOSLAT,
      "FS_POS_LNG": FSPOSLNG,
      "FS_KD_KAB": FSKDKAB,
      "FS_KD_KEC": FSKDKEC,
      "FS_KD_KEL": FSKDKEL,
      "FS_KD_PUS": FSKDPUS,
      "FS_NO_TLP": FSNOTLP,
      "FS_KD_STATE": FSKDSTATE,
      "FS_IMAGE": _image,
    }).then((response) {
      msgAPI = response.body;
      if (msgAPI != "") {
        //uploadImage();
        // addStringToSF(nik,msgAPI,nama,alamat, tempatLahir, tanggalLahir,alamatKtp);
        showMessage(context, "Perhatian. ", "Data berhasil tersimpan. ");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            //return HomeScreen();
            //return Landing();
          }),
        );
      } else {
        showMessage(context, "Perhatian", "Data gagal tersimpan");
      }
    });
  }

  void confirmMessage(
      BuildContext context,
      String dTitle,
      String dMessage,
      nik,
      nama,
      namaIbu,
      tempatLahir,
      tanggalLahir,
      alamat,
      noTelp,
      agama,
      jenisKelamin,
      alamatKtp,
      keluhan,
      _currentPosition2,
      selectedKabupaten,
      selectedKecamatan,
      selectedDesa,
      selectedPuskesmas,
      _jenisKelamin) {
    if (jenisKelamin == "") {
      jenisKelamin = "1";
    }

    Widget cancelButton = ElevatedButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () async {
        Navigator.of(context).pop();
        //saveForm(context,nik,nama,namaIbu,tempatLahir,tanggalLahir,alamat,noTelp,agama,jenisKelamin,alamatKtp,keluhan,_currentPosition2,
        //   selectedKabupaten,selectedKecamatan,selectedDesa,selectedPuskesmas,_jenisKelamin);
        saveUploadImage(
            context,
            nik,
            nama,
            namaIbu,
            tempatLahir,
            tanggalLahir,
            alamat,
            noTelp,
            agama,
            jenisKelamin,
            alamatKtp,
            keluhan,
            _currentPosition2,
            selectedKabupaten,
            selectedKecamatan,
            selectedDesa,
            selectedPuskesmas,
            _jenisKelamin);
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

  void showMessage(context, String dTitle, String dMessage) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
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

  void showMessageAct(context, String dTitle, String dMessage) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            //return Landing();
          }),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
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

  // addStringToSF(String nik, String no_rm, String nama, String alamat,String tempat_lahir, String tanggal_lahir,alamatKtp) async {

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   prefs.setBool("isLogin", true);
  //   prefs.setString("loginOK", "Yes");
  //   prefs.setString("nik", nik);
  //   prefs.setString("no_rm", no_rm);
  //   prefs.setString("nama", nama);
  //   prefs.setString("alamat", alamat);
  //   prefs.setString("alamatKtp", alamatKtp);
  //   prefs.setString("alamatKota", "-");
  //   prefs.setString("tempatlahir", tempat_lahir);
  //   prefs.setString("tanggallahir", tanggal_lahir);
  //   prefs.setString("jenispasien", "baru");

  //   prefs.setBool("isBooked", false);
  //   prefs.setString("antrianNoBooking", "");
  //   prefs.setString("antrianDate", "");
  //   prefs.setString("antrianNo", "");
  //   prefs.setString("kodeBooking", "");

  // }

//---------------
}
