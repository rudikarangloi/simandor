// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  Province({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() => name;
}
/*
{
"IDT": "30",
"Referensi": "ALT.00000000030",
"Ref_Group": "",
"Ref_Mutasi": "",
"Ref_Usulan": "",
"Ref_History": "",
"Ref_Usulan_His": "",
"Kd_UPB": "24.04.01.01.01.001",
"Kd_Aset": "",
"Kd_Aset_108": "1.3.2.02.01.04.001",
"Kd_Ruang": "000",
"No_Register": "0009901",
"No_Pengadaan": "",
"Ref_Temp": "",
"Nm_Aset": "Sepeda motor",
"Kd_Pemilik": "12",
"Tgl_Perolehan": "2006-12-31",
"Tgl_Mutasi": "0000-00-00",
"Tgl_Mulai": "0000-00-00",
"Tahun": "0",
"Luas_M2": "0.00",
"Alamat": "",
"Hak_Tanah": "",
"Sertifikat": "Tidak Ada",
"Sertifikat_Tanggal": "0000-00-00",
"Sertifikat_Nomor": "",
"Penggunaan": "",
"Asal_Usul": "Belanja Modal",
"Harga": "10000000.00",
"No_SP2D": "",
"Merk": "suzuki thunder",
"Type": "-",
"Ukuran_CC": "125 cc",
"Bahan": "Plastik, Besi dll",
"Nomor_Pabrik": "-",
"Nomor_Rangka": "-MH8EN125A6J-319344",
"Nomor_Mesin": "FA05-10-318864",
"Nomor_Polisi": "DA 719 Y",
"Nomor_Polisi_Lama": "",
"Nomor_BPKB": "E No 254485M",
"Pemegang": "",
"Pemegang_Lama": "",
"Kondisi": "B",
"Masa_Manfaat": "7",
"Nilai_Akhir": "10000000.00",
"Bertingkat": "",
"Beton": "",
"Luas_Lantai": "0.00",
"Lokasi": "",
"Dokumen_Nomor": "",
"Status_Tanah": "",
"Kd_Tanah1": "0",
"Kd_Tanah2": "0",
"Kd_Tanah3": "0",
"Kd_Tanah4": "0",
"Kd_Tanah5": "0",
"Luas_Tanah": "0.00",
"Kode_Tanah_Old": "0",
"Kode_Tanah": "",
"Konstruksi": "",
"Panjang": "0.00",
"Lebar": "0.00",
"Luas": "0.00",
"Judul": "",
"Spesifikasi": "",
"Pencipta": "",
"Daerah_Asal": "",
"Jenis": "",
"Tipe_Bangunan": "-",
"KdpToAset": "N",
"Ukuran": "0.00",
"Keterangan": "APP 2006",
"Post": "Y",
"file_content": null,
"file_name": "",
"file_type": "",
"file_size": "0",
"extracom": "N",
"MasukKeUsulan": "belum",
"Status": "",
"ImportFrom": null,
"Recorded": "2021-11-30 20:55:52",
"Pencatat": "creator-ImpXLS",
"IdTabelMaster": "0"
}
*/
