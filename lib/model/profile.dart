class Privacy {
  String no;
  String isi;
  String urutan;
  String gambar;

  Privacy({this.isi, this.urutan, this.gambar, this.no});

  Privacy.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    isi = json['isi'];
    urutan = json['urutan'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
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
  String id_prov;
  String namaprov;
  String id_kab;
  String namakab;

  User(
      {this.firstname,
      this.lastname,
      this.address,
      this.ktp,
      this.ktpVerify,
      this.hp,
      this.ishpVerify,
      this.foto,
      this.id_kab,
      this.id_prov,
      this.namakab,
      this.namaprov
      });

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    address = json['address'];
    ktp = json['ktp'];
    ktpVerify = json['ktp_verify'];
    hp = json['hp'];
    ishpVerify = json['ishp_verify'];
    foto = json['foto'];
    id_prov = json['id_prov'];
    namaprov = json['namaprov'];
    id_kab = json['id_kab'];
    namakab = json['namakab'];
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
    data['id_prov'] = this.id_prov;
    data['namaprov'] = this.namaprov;
    data['id_kab'] = this.id_kab;
    data['namakab'] = this.namakab;
    return data;
  }
}

class Province {
  String idProv;
  String nama;

  Province({this.idProv, this.nama});

  Province.fromJson(Map<String, dynamic> json) {
    idProv = json['id_prov'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_prov'] = this.idProv;
    data['nama'] = this.nama;
    return data;
  }
}

class Kabkot {
  String idKab;
  String idProv;
  String nama;
  String idJenis;

  Kabkot({this.idKab, this.idProv, this.nama, this.idJenis});

  Kabkot.fromJson(Map<String, dynamic> json) {
    idKab = json['id_kab'];
    idProv = json['id_prov'];
    nama = json['nama'];
    idJenis = json['id_jenis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_kab'] = this.idKab;
    data['id_prov'] = this.idProv;
    data['nama'] = this.nama;
    data['id_jenis'] = this.idJenis;
    return data;
  }
}
