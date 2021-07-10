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
class Rekening {
  String norek;
  String nama;
  String bank;
  String gambar;

  Rekening({this.norek, this.nama, this.bank, this.gambar});

  Rekening.fromJson(Map<String, dynamic> json) {
    norek = json['norek'];
    nama = json['nama'];
    bank = json['bank'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['norek'] = this.norek;
    data['nama'] = this.nama;
    data['bank'] = this.bank;
    data['gambar'] = this.gambar;
    return data;
  }
}

class ListBank {
  String id;
  String bank;
  String urutan;
  String gambar;

  ListBank({this.id, this.bank, this.urutan, this.gambar});

  ListBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    urutan = json['urutan'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank'] = this.bank;
    data['urutan'] = this.urutan;
    data['gambar'] = this.gambar;
    return data;
  }
}
