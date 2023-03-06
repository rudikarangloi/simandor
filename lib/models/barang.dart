import 'dart:convert';

Barang barangFromJson(String str) => Barang.fromJson(json.decode(str));

String barangToJson(Barang data) => json.encode(data.toJson());

class Barang {
  Barang({
    this.idt,
    this.referensi,
    this.refGroup,
    this.refMutasi,
    this.refUsulan,
    this.refHistory,
    this.refUsulanHis,
    this.kdUpb,
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
    this.noSp2D,
    this.merk,
    this.type,
    this.ukuranCc,
    this.bahan,
    this.nomorPabrik,
    this.nomorRangka,
    this.nomorMesin,
    this.nomorPolisi,
    this.nomorPolisiLama,
    this.nomorBpkb,
    this.pemegang,
    this.pemegangLama,
    this.kondisi,
    this.masaManfaat,
    this.nilaiAkhir,
    this.bertingkat,
    this.beton,
    this.luasLantai,
    this.lokasi,
    this.fileName,
    this.keterangan,
  });

  String idt;
  String referensi;
  String refGroup;
  String refMutasi;
  String refUsulan;
  String refHistory;
  String refUsulanHis;
  String kdUpb;
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
  String noSp2D;
  String merk;
  String type;
  String ukuranCc;
  String bahan;
  String nomorPabrik;
  String nomorRangka;
  String nomorMesin;
  String nomorPolisi;
  String nomorPolisiLama;
  String nomorBpkb;
  String pemegang;
  String pemegangLama;
  String kondisi;
  String masaManfaat;
  String nilaiAkhir;
  String bertingkat;
  String beton;
  String luasLantai;
  String lokasi;
  String fileName;
  String keterangan;

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        idt: json["IDT"],
        referensi: json["Referensi"],
        refGroup: json["Ref_Group"],
        refMutasi: json["Ref_Mutasi"],
        refUsulan: json["Ref_Usulan"],
        refHistory: json["Ref_History"],
        refUsulanHis: json["Ref_Usulan_His"],
        kdUpb: json["Kd_UPB"],
        kdAset: json["Kd_Aset"],
        kdAset108: json["Kd_Aset_108"],
        kdRuang: json["Kd_Ruang"],
        noRegister: json["No_Register"],
        noPengadaan: json["No_Pengadaan"],
        refTemp: json["Ref_Temp"],
        nmAset: json["Nm_Aset"],
        kdPemilik: json["Kd_Pemilik"],
        tglPerolehan: json["Tgl_Perolehan"],
        tglMutasi: json["Tgl_Mutasi"],
        tglMulai: json["Tgl_Mulai"],
        tahun: json["Tahun"],
        luasM2: json["Luas_M2"],
        alamat: json["Alamat"],
        hakTanah: json["Hak_Tanah"],
        sertifikat: json["Sertifikat"],
        sertifikatTanggal: json["Sertifikat_Tanggal"],
        sertifikatNomor: json["Sertifikat_Nomor"],
        penggunaan: json["Penggunaan"],
        asalUsul: json["Asal_Usul"],
        harga: json["Harga"],
        noSp2D: json["No_SP2D"],
        merk: json["Merk"],
        type: json["Type"],
        ukuranCc: json["Ukuran_CC"],
        bahan: json["Bahan"],
        nomorPabrik: json["Nomor_Pabrik"],
        nomorRangka: json["Nomor_Rangka"],
        nomorMesin: json["Nomor_Mesin"],
        nomorPolisi: json["Nomor_Polisi"],
        nomorPolisiLama: json["Nomor_Polisi_Lama"],
        nomorBpkb: json["Nomor_BPKB"],
        pemegang: json["Pemegang"],
        pemegangLama: json["Pemegang_Lama"],
        kondisi: json["Kondisi"],
        masaManfaat: json["Masa_Manfaat"],
        nilaiAkhir: json["Nilai_Akhir"],
        bertingkat: json["Bertingkat"],
        beton: json["Beton"],
        luasLantai: json["Luas_Lantai"],
        lokasi: json["Lokasi"],
        fileName: json["file_name"],
        keterangan: json["Keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "Referensi": referensi,
        "Ref_Group": refGroup,
        "Ref_Mutasi": refMutasi,
        "Ref_Usulan": refUsulan,
        "Ref_History": refHistory,
        "Ref_Usulan_His": refUsulanHis,
        "Kd_UPB": kdUpb,
        "Kd_Aset": kdAset,
        "Kd_Aset_108": kdAset108,
        "Kd_Ruang": kdRuang,
        "No_Register": noRegister,
        "No_Pengadaan": noPengadaan,
        "Ref_Temp": refTemp,
        "Nm_Aset": nmAset,
        "Kd_Pemilik": kdPemilik,
        "Tgl_Perolehan": tglPerolehan,
        // "Tgl_Perolehan":
        //     "${tglPerolehan.year.toString().padLeft(4, '0')}-${tglPerolehan.month.toString().padLeft(2, '0')}-${tglPerolehan.day.toString().padLeft(2, '0')}",
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
        "No_SP2D": noSp2D,
        "Merk": merk,
        "Type": type,
        "Ukuran_CC": ukuranCc,
        "Bahan": bahan,
        "Nomor_Pabrik": nomorPabrik,
        "Nomor_Rangka": nomorRangka,
        "Nomor_Mesin": nomorMesin,
        "Nomor_Polisi": nomorPolisi,
        "Nomor_Polisi_Lama": nomorPolisiLama,
        "Nomor_BPKB": nomorBpkb,
        "Pemegang": pemegang,
        "Pemegang_Lama": pemegangLama,
        "Kondisi": kondisi,
        "Masa_Manfaat": masaManfaat,
        "Nilai_Akhir": nilaiAkhir,
        "Bertingkat": bertingkat,
        "Beton": beton,
        "Luas_Lantai": luasLantai,
        "Lokasi": lokasi,
        "file_name": fileName,
        "Keterangan": keterangan,
      };

  @override
  //String toString() => merk;
  String toString() => noRegister;
}
