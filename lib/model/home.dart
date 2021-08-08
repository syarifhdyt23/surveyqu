class Pengumuman {
  String isi;
  String urutan;
  String gambar;
  String url;

  Pengumuman({this.isi, this.urutan, this.gambar, this.url});

  Pengumuman.fromJson(Map<String, dynamic> json) {
    isi = json['isi'];
    urutan = json['urutan'];
    gambar = json['gambar'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isi'] = this.isi;
    data['urutan'] = this.urutan;
    data['gambar'] = this.gambar;
    data['url'] = this.url;
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

class Advertising {
  String isi;
  String urutan;
  String gambar;
  String url;

  Advertising({this.isi, this.urutan, this.gambar, this.url});

  Advertising.fromJson(Map<String, dynamic> json) {
    isi = json['isi'];
    urutan = json['urutan'];
    gambar = json['gambar'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isi'] = this.isi;
    data['urutan'] = this.urutan;
    data['gambar'] = this.gambar;
    data['url'] = this.url;
    return data;
  }
}

class QSurvey {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;

  QSurvey({this.judul, this.deskripsi, this.id, this.color, this.gambar});

  QSurvey.fromJson(Map<String, dynamic> json) {
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

class NotifHome {
  int status;
  String statNotif;

  NotifHome({this.status, this.statNotif});

  NotifHome.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statNotif = json['stat_notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['stat_notif'] = this.statNotif;
    return data;
  }
}

class HomeContent {
  String api;
  String urutan;
  String nama;
  String judul;
  String imgurl;
  String jenis;
  String status;
  String divisi;

  HomeContent(
      {this.api,
        this.urutan,
        this.nama,
        this.judul,
        this.imgurl,
        this.jenis,
        this.status,
        this.divisi});

  HomeContent.fromJson(Map<String, dynamic> json) {
    api = json['api'];
    urutan = json['urutan'];
    nama = json['nama'];
    judul = json['judul'];
    imgurl = json['imgurl'];
    jenis = json['jenis'];
    status = json['status'];
    divisi = json['divisi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = this.api;
    data['urutan'] = this.urutan;
    data['nama'] = this.nama;
    data['judul'] = this.judul;
    data['imgurl'] = this.imgurl;
    data['jenis'] = this.jenis;
    data['status'] = this.status;
    data['divisi'] = this.divisi;
    return data;
  }
}

class Qnews {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;

  Qnews({this.judul, this.deskripsi, this.id, this.color, this.gambar});

  Qnews.fromJson(Map<String, dynamic> json) {
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