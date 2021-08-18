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

class Pengumuman {
  String judul;
  String isi;
  String urutan;
  String gambar;
  String url;

  Pengumuman({this.judul, this.isi, this.urutan, this.gambar, this.url});

  Pengumuman.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    urutan = json['urutan'];
    gambar = json['gambar'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['urutan'] = this.urutan;
    data['gambar'] = this.gambar;
    data['url'] = this.url;
    return data;
  }
}

class Tutorial {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String quota;
  String jenis;
  String header;
  String headerS;

  Tutorial(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.jenis,
        this.header,
        this.headerS});

  Tutorial.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    return data;
  }
}


class Qscreen {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String quota;
  String jenis;
  String header;
  String headerS;

  Qscreen(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.jenis,
        this.header,
        this.headerS});

  Qscreen.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    return data;
  }
}

class Qsurvey {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String quota;
  String jenis;
  String header;
  String headerS;

  Qsurvey(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.jenis,
        this.header,
        this.headerS});

  Qsurvey.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    return data;
  }
}

class Qgames {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String quota;
  String jenis;
  String header;
  String headerS;

  Qgames(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.jenis,
        this.header,
        this.headerS});

  Qgames.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    return data;
  }
}

class Qnews {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String quota;
  String jenis;
  String header;
  String headerS;

  Qnews(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.jenis,
        this.header,
        this.headerS});

  Qnews.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    return data;
  }
}

