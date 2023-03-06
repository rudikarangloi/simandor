class Produk {
  final String id;
  final String kode;
  final String nama_produk;
  final String harga;
  final String deskripsi;
  final String stok;

  Produk(
      {this.id,
      this.kode,
      this.nama_produk,
      this.harga,
      this.deskripsi,
      this.stok});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      kode: json['kode'],
      nama_produk: json['nama_produk'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      stok: json['stok'],
    );
  }
}
