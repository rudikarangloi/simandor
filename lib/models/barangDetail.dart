import 'dart:convert';

BarangDetail barangFromJson(String str) =>
    BarangDetail.fromJson(json.decode(str));

String barangDetailToJson(BarangDetail data) => json.encode(data.toJson());

class BarangDetail {
  BarangDetail(
      {this.idt,
      this.referensi,
      this.refGroup,
      this.refMutasi,
      this.refUsulan,
      this.refHistory,
      this.refUsulanHis,
      this.kdUPB,
      this.kdAset,
      this.kdAset108,
      this.kdRuang,
      this.noRegister,
      this.noPengadaan,
      this.refTemp,
      this.nmAset,
      this.kdPemilik,
      this.tglPerolehan,
      this.tglMutasi,
      this.tglMulai,
      this.tahun,
      this.luasM2,
      this.alamat,
      this.hakTanah,
      this.sertifikat,
      this.sertifikatTanggal,
      this.sertifikatNomor,
      this.penggunaan,
      this.asalUsul,
      this.harga,
      this.noSP2D,
      this.merk,
      this.type,
      this.ukuranCC,
      this.bahan,
      this.nomorPabrik,
      this.nomorRangka,
      this.nomorMesin,
      this.nomorPolisi,
      this.nomorPolisiLama,
      this.nomorBPKB,
      this.pemegang,
      this.pemegangLama,
      this.kondisi,
      this.masaManfaat,
      this.nilaiAkhir,
      this.bertingkat,
      this.beton,
      this.luasLantai,
      this.lokasi,
      this.dokumenTanggal,
      this.dokumenNomor,
      this.statusTanah,
      this.kdTanah1,
      this.kdTanah2,
      this.kdTanah3,
      this.kdTanah4,
      this.kdTanah5,
      this.luasTanah,
      this.kodeTanahOld,
      this.kodeTanah,
      this.konstruksi,
      this.panjang,
      this.lebar,
      this.luas,
      this.judul,
      this.spesifikasi,
      this.pencipta,
      this.daerahAsal,
      this.jenis,
      this.tipeBangunan,
      this.kdpToAset,
      this.ukuran,
      this.keterangan,
      this.post,
      this.fileName,
      this.fileType,
      this.fileSize,
      this.extracom,
      this.masukKeUsulan,
      this.status,
      this.importFrom,
      this.recorded,
      this.pencatat,
      this.idTabelMaster,
      this.kodeBar,
      this.lat,
      this.lng,
      this.latLng});

  String idt;
  String referensi;
  String refGroup;
  String refMutasi;
  String refUsulan;
  String refHistory;
  String refUsulanHis;
  String kdUPB;
  String kdAset;
  String kdAset108;
  String kdRuang;
  String noRegister;
  String noPengadaan;
  String refTemp;
  String nmAset;
  String kdPemilik;
  String tglPerolehan;
  String tglMutasi;
  String tglMulai;
  String tahun;
  String luasM2;
  String alamat;
  String hakTanah;
  String sertifikat;
  String sertifikatTanggal;
  String sertifikatNomor;
  String penggunaan;
  String asalUsul;
  String harga;
  String noSP2D;
  String merk;
  String type;
  String ukuranCC;
  String bahan;
  String nomorPabrik;
  String nomorRangka;
  String nomorMesin;
  String nomorPolisi;
  String nomorPolisiLama;
  String nomorBPKB;
  String pemegang;
  String pemegangLama;
  String kondisi;
  String masaManfaat;
  String nilaiAkhir;
  String bertingkat;
  String beton;
  String luasLantai;
  String lokasi;
  String dokumenTanggal;
  String dokumenNomor;
  String statusTanah;
  String kdTanah1;
  String kdTanah2;
  String kdTanah3;
  String kdTanah4;
  String kdTanah5;
  String luasTanah;
  String kodeTanahOld;
  String kodeTanah;
  String konstruksi;
  String panjang;
  String lebar;
  String luas;
  String judul;
  String spesifikasi;
  String pencipta;
  String daerahAsal;
  String jenis;
  String tipeBangunan;
  String kdpToAset;
  String ukuran;
  String keterangan;
  String post;
  String fileName;
  String fileType;
  String fileSize;
  String extracom;
  String masukKeUsulan;
  String status;
  String importFrom;
  String recorded;
  String pencatat;
  String idTabelMaster;
  String kodeBar;
  String lat;
  String lng;
  String latLng;

// factory Barang.fromJson(Map<String, dynamic> json) => Barang(
//         idt: json["IDT"],

  factory BarangDetail.fromJson(Map<String, dynamic> json) => BarangDetail(
        idt: json['IDT'],
        referensi: json['Referensi'],
        refGroup: json['Ref_Group'],
        refMutasi: json['Ref_Mutasi'],
        refUsulan: json['Ref_Usulan'],
        refHistory: json['Ref_History'],
        refUsulanHis: json['Ref_Usulan_His'],
        kdUPB: json['Kd_UPB'],
        kdAset: json['Kd_Aset'],
        kdAset108: json['Kd_Aset_108'],
        kdRuang: json['Kd_Ruang'],
        noRegister: json['No_Register'],
        noPengadaan: json['No_Pengadaan'],
        refTemp: json['Ref_Temp'],
        nmAset: json['Nm_Aset'],
        kdPemilik: json['Kd_Pemilik'],
        tglPerolehan: json['Tgl_Perolehan'],
        tglMutasi: json['Tgl_Mutasi'],
        tglMulai: json['Tgl_Mulai'],
        tahun: json['Tahun'],
        luasM2: json['Luas_M2'],
        alamat: json['Alamat'],
        hakTanah: json['Hak_Tanah'],
        sertifikat: json['Sertifikat'],
        sertifikatTanggal: json['Sertifikat_Tanggal'],
        sertifikatNomor: json['Sertifikat_Nomor'],
        penggunaan: json['Penggunaan'],
        asalUsul: json['Asal_Usul'],
        harga: json['Harga'],
        noSP2D: json['No_SP2D'],
        merk: json['Merk'],
        type: json['Type'],
        ukuranCC: json['Ukuran_CC'],
        bahan: json['Bahan'],
        nomorPabrik: json['Nomor_Pabrik'],
        nomorRangka: json['Nomor_Rangka'],
        nomorMesin: json['Nomor_Mesin'],
        nomorPolisi: json['Nomor_Polisi'],
        nomorPolisiLama: json['Nomor_Polisi_Lama'],
        nomorBPKB: json['Nomor_BPKB'],
        pemegang: json['Pemegang'],
        pemegangLama: json['Pemegang_Lama'],
        kondisi: json['Kondisi'],
        masaManfaat: json['Masa_Manfaat'],
        nilaiAkhir: json['Nilai_Akhir'],
        bertingkat: json['Bertingkat'],
        beton: json['Beton'],
        luasLantai: json['Luas_Lantai'],
        lokasi: json['Lokasi'],
        dokumenTanggal: json['Dokumen_Tanggal'],
        dokumenNomor: json['Dokumen_Nomor'],
        statusTanah: json['Status_Tanah'],
        kdTanah1: json['Kd_Tanah1'],
        kdTanah2: json['Kd_Tanah2'],
        kdTanah3: json['Kd_Tanah3'],
        kdTanah4: json['Kd_Tanah4'],
        kdTanah5: json['Kd_Tanah5'],
        luasTanah: json['Luas_Tanah'],
        kodeTanahOld: json['Kode_Tanah_Old'],
        kodeTanah: json['Kode_Tanah'],
        konstruksi: json['Konstruksi'],
        panjang: json['Panjang'],
        lebar: json['Lebar'],
        luas: json['Luas'],
        judul: json['Judul'],
        spesifikasi: json['Spesifikasi'],
        pencipta: json['Pencipta'],
        daerahAsal: json['Daerah_Asal'],
        jenis: json['Jenis'],
        tipeBangunan: json['Tipe_Bangunan'],
        kdpToAset: json['KdpToAset'],
        ukuran: json['Ukuran'],
        keterangan: json['Keterangan'],
        post: json['Post'],
        fileName: json['file_name'],
        fileType: json['file_type'],
        fileSize: json['file_size'],
        extracom: json['extracom'],
        masukKeUsulan: json['MasukKeUsulan'],
        status: json['Status'],
        importFrom: json['ImportFrom'],
        recorded: json['Recorded'],
        pencatat: json['Pencatat'],
        idTabelMaster: json['IdTabelMaster'],
        kodeBar: json['kode_bar'],
        lat: json['lat'],
        lng: json['lng'],
        latLng: json['lat_lng'],
      );

  //Map<String, dynamic> toJson() => {
  //final Map<String, dynamic> data = new Map<String, dynamic>();
  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "Referensi": referensi,
        "Ref_Group": refGroup,
        "Ref_Mutasi": refMutasi,
        "Ref_Usulan": refUsulan,
        "Ref_History": refHistory,
        "Ref_Usulan_His": refUsulanHis,
        "Kd_UPB": kdUPB,
        "Kd_Aset": kdAset,
        "Kd_Aset_108": kdAset108,
        "Kd_Ruang": kdRuang,
        "No_Register": noRegister,
        "No_Pengadaan": noPengadaan,
        "Ref_Temp": refTemp,
        "Nm_Aset": nmAset,
        "Kd_Pemilik": kdPemilik,
        "Tgl_Perolehan": tglPerolehan,
        "Tgl_Mutasi": tglMutasi,
        "Tgl_Mulai": tglMulai,
        "Tahun": tahun,
        "Luas_M2": luasM2,
        "Alamat": alamat,
        "Hak_Tanah": hakTanah,
        "Sertifikat": sertifikat,
        "Sertifikat_Tanggal": sertifikatTanggal,
        "Sertifikat_Nomor": sertifikatNomor,
        "Penggunaan": penggunaan,
        "Asal_Usul": asalUsul,
        "Harga": harga,
        "No_SP2D": noSP2D,
        "Merk": merk,
        "Type": type,
        "Ukuran_CC": ukuranCC,
        "Bahan": bahan,
        "Nomor_Pabrik": nomorPabrik,
        "Nomor_Rangka": nomorRangka,
        "Nomor_Mesin": nomorMesin,
        "Nomor_Polisi": nomorPolisi,
        "Nomor_Polisi_Lama": nomorPolisiLama,
        "Nomor_BPKB": nomorBPKB,
        "Pemegang": pemegang,
        "Pemegang_Lama": pemegangLama,
        "Kondisi": kondisi,
        "Masa_Manfaat": masaManfaat,
        "Nilai_Akhir": nilaiAkhir,
        "Bertingkat": bertingkat,
        "Beton": beton,
        "Luas_Lantai": luasLantai,
        "Lokasi": lokasi,
        "Dokumen_Tanggal": dokumenTanggal,
        "Dokumen_Nomor": dokumenNomor,
        "Status_Tanah": statusTanah,
        "Kd_Tanah1": kdTanah1,
        "Kd_Tanah2": kdTanah2,
        "Kd_Tanah3": kdTanah3,
        "Kd_Tanah4": kdTanah4,
        "Kd_Tanah5": kdTanah5,
        "Luas_Tanah": luasTanah,
        "Kode_Tanah_Old": kodeTanahOld,
        "Kode_Tanah": kodeTanah,
        "Konstruksi": konstruksi,
        "Panjang": panjang,
        "Lebar": lebar,
        "Luas": luas,
        "Judul": judul,
        "Spesifikasi": spesifikasi,
        "Pencipta": pencipta,
        "Daerah_Asal": daerahAsal,
        "Jenis": jenis,
        "Tipe_Bangunan": tipeBangunan,
        "KdpToAset": kdpToAset,
        "Ukuran": ukuran,
        "Keterangan": keterangan,
        "Post": post,
        "file_name": fileName,
        "file_type": fileType,
        "file_size": fileSize,
        "extracom": extracom,
        "MasukKeUsulan": masukKeUsulan,
        "Status": status,
        "ImportFrom": importFrom,
        "Recorded": recorded,
        "Pencatat": pencatat,
        "IdTabelMaster": idTabelMaster,
        "kode_bar": kodeBar,
        "lat": lat,
        "lng": lng,
        "lat_lng": latLng,
      };

  @override
  String toString() => nmAset;
}
