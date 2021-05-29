class Privacy {
  String isi;
  String urutan;
  String gambar;

  Privacy({this.isi, this.urutan, this.gambar});

  Privacy.fromJson(Map<String, dynamic> json) {
    isi = json['isi'];
    urutan = json['urutan'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isi'] = this.isi;
    data['urutan'] = this.urutan;
    data['gambar'] = this.gambar;
    return data;
  }
}
