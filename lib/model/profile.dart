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

class User {
  String firstname;
  String lastname;
  String address;
  String ktp;
  String ktpVerify;
  String hp;
  String ishpVerify;
  String foto;

  User(
      {this.firstname,
        this.lastname,
        this.address,
        this.ktp,
        this.ktpVerify,
        this.hp,
        this.ishpVerify,
        this.foto});

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    address = json['address'];
    ktp = json['ktp'];
    ktpVerify = json['ktp_verify'];
    hp = json['hp'];
    ishpVerify = json['ishp_verify'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['address'] = this.address;
    data['ktp'] = this.ktp;
    data['ktp_verify'] = this.ktpVerify;
    data['hp'] = this.hp;
    data['ishp_verify'] = this.ishpVerify;
    data['foto'] = this.foto;
    return data;
  }
}
