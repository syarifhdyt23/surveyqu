class Pengumuman {
  String isi;
  String urutan;
  String gambar;

  Pengumuman({this.isi, this.urutan, this.gambar});

  Pengumuman.fromJson(Map<String, dynamic> json) {
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

class Question {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;

  Question({this.judul, this.deskripsi, this.id, this.color, this.gambar});

  Question.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    return data;
  }
}