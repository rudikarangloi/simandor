import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;
  DBHelper._createObject();
  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'historyAntrian.db';
    var todoBatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoBatabase;
  }

  void _createDb(Database db, int version) async {
    //loginOK,isLogin, isBooked,nik,no_rm, nama,alamat,alamatKtp,alamatKota,tempatlahir, tanggallahir, jenispasien, antrianDate, antrianNo, antrianNoBooking, PoliklinikName,PoliklinikNo, kodeBooking, jenisantrianpoliklinik, qr,kodePerusahaan,namaPerusahaan, kodeBPJS, namaPesertaBPJS, statusPesertaBPJS, kelasPesertaBPJS, jenisPesertaBPJS, telpPesertaBPJS, noKartuPesertaBPJS, nikPesertaBPJS
    await db.execute(
        "CREATE TABLE historyAntrian (id INTEGER PRIMARY KEY AUTOINCREMENT, loginOK TEXT, isLogin TEXT, isBooked TEXT, nik TEXT,no_rm TEXT, nama TEXT,alamat TEXT,alamatKtp TEXT,alamatKota TEXT,tempatlahir TEXT, tanggallahir TEXT, jenispasien TEXT, antrianDate TEXT, antrianNo TEXT, antrianNoBooking TEXT, PoliklinikName TEXT,PoliklinikNo TEXT, kodeBooking TEXT, jenisantrianpoliklinik TEXT, qr TEXT,kodePerusahaan TEXT,namaPerusahaan TEXT, kodeBPJS TEXT, namaPesertaBPJS TEXT, statusPesertaBPJS TEXT, kelasPesertaBPJS TEXT, jenisPesertaBPJS TEXT, telpPesertaBPJS TEXT, noKartuPesertaBPJS TEXT, nikPesertaBPJS TEXT) ");
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('historyAntrian', orderBy: 'nama');
    return mapList;
  }

  // Future<int> insert(AntrianModel object) async{
  //   Database db = await this.database;
  //   int count = await db.insert('historyAntrian', object.toMap());
  //   return count;
  // }

  // Future<int> update(AntrianModel object) async{
  //   Database db = await this.database;
  //   int count = await db.update('historyAntrian', object.toMap(), where: 'id=?', whereArgs: [object.id]);
  //   return count;
  // }

  // Future<int> updateByNik(AntrianModel object) async{
  //   Database db = await this.database;
  //   int count = await db.update('historyAntrian', object.toMap(), where: 'nik=?', whereArgs: [object.nik]);
  //   return count;
  // }

  // Future<int> delete(int id) async{
  //   Database db = await this.database;
  //   int count = await db.delete('historyAntrian', where: 'id=?', whereArgs: [id]);
  //   return count;
  // }

  // Future<List<AntrianModel>> getHistoryList() async{
  //     var historyMapList = await select();
  //     int count = historyMapList.length;
  //     List<AntrianModel> historyList = List<AntrianModel>();
  //     for(int i=0; i<count;i++){
  //       historyList.add(AntrianModel.fromMap(historyMapList[i]));
  //     }

  //     return historyList;
  // }

  Future<List<Map<String, dynamic>>> selectOneRow(String nik) async {
    Database db = await this.database;
    var mapList =
        await db.query('historyAntrian', where: 'nik=?', whereArgs: [nik]);
    return mapList;
  }

  // Future<List<AntrianModel>> getHistoryOneRow(String nik) async{
  //   var historyMapList = await selectOneRow(nik);
  //   int count = historyMapList.length;
  //   List<AntrianModel> historyList = List<AntrianModel>();
  //   for(int i=0; i<count;i++){
  //     historyList.add(AntrianModel.fromMap(historyMapList[i]));
  //   }

  //   return historyList;
  // }

  //FIND
  // getHistoryById(int id) async {
  //   final db = await database;
  //   var res =await  db.query("historyAntrian", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? AntrianModel.fromMap(res.first) : Null ;
  // }

  // getHistoryByNik(String nik) async {
  //   final db = await database;
  //   var res =await  db.query("historyAntrian", where: "nik = ?", whereArgs: [nik]);
  //   return res.isNotEmpty ? AntrianModel.fromMap(res.first) : '0' ;
  // }

  // getAllHistories() async {
  //   final db = await database;
  //   var res = await db.query("historyAntrian");
  //   List<AntrianModel> list =  res.isNotEmpty ? res.map((c) => AntrianModel.fromMap(c)).toList() : [];
  //   return list;
  // }

  // getJenisAntrianHistories() async {
  //   final db = await database;
  //   var res = await db.rawQuery("SELECT * FROM historyAntrian WHERE jenisantrianpoliklinik=1");
  //   List<AntrianModel> list = res.isNotEmpty ? res.toList().map((c) => AntrianModel.fromMap(c)) : null;
  //   return list;
  // }

  // //INSERT RAW
  // newHistoryRaw(AntrianModel newHistory) async {
  //   final db = await database;
  //   var res = await db.rawInsert("INSERT Into historyAntrian (id,nama,no_rm,alamat) VALUES (${newHistory.id},${newHistory.nik},${newHistory.no_rm},${newHistory.alamat})");
  //   return res;
  // }

  //INSERT
  // newHistory(AntrianModel newHistory) async {
  //   final db = await database;
  //   var res = await db.insert("historyAntrian", newHistory.toMap());
  //   return res;
  // }

  // //UPDATE
  // updateClient(AntrianModel newHistory) async {
  //   final db = await database;
  //   var res = await db.update("historyAntrian", newHistory.toMap(),
  //       where: "id = ?", whereArgs: [newHistory.id]);
  //   return res;
  // }
  //Update RAW
  updateHistoryRaw(List<dynamic> valuesName, String sqlParam) async {
    final db = await database;
    var res =
        await db.rawInsert("UPDATE  historyAntrian SET $sqlParam", valuesName);
    return res;
  }

  /*
  blockOrUnblock(AntrianModel newHistory) async {
    final db = await database;
    AntrianModel blocked = AntrianModel(id: newHistory.id,  nama: newHistory.nama,     lastName: newHistory.no_rm,     blocked: !newHistory.blocked);
    var res = await db.update("Client", blocked.toMap(),
        where: "id = ?", whereArgs: [newHistory.id]);
    return res;
  }

   */

  //DELETE
  deleteHistory(int id) async {
    final db = await database;
    db.delete("historyAntrian", where: "id = ?", whereArgs: [id]);
  }

  deleteAllHistory() async {
    final db = await database;
    db.rawDelete("Delete * from historyAntrian");
  }

  // Future<AntrianModel> getCustomer(String nik) async {
  //   final db = await database;
  //   var results = await db.rawQuery('SELECT * FROM historyAntrian WHERE nik = $nik');

  //   if (results.length > 0) {
  //     return new AntrianModel.fromMap(results.first);
  //   }
  //   return null;
  // }

  // getJenisAntrianHistories2() async {
  //   final db = await database;
  //   var res = await db.rawQuery("SELECT * FROM historyAntrian WHERE jenisantrianpoliklinik=1");
  //   List<AntrianModel> list = res.isNotEmpty ? res.toList().map((c) => AntrianModel.fromMap(c)) : null;
  //   return list;
  // }

}
