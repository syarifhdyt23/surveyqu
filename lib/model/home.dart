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
  String autoscroll;

  Pengumuman(
      {this.judul,
        this.isi,
        this.urutan,
        this.gambar,
        this.url,
        this.autoscroll});

  Pengumuman.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    urutan = json['urutan'];
    gambar = json['gambar'];
    url = json['url'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['urutan'] = this.urutan;
    data['gambar'] = this.gambar;
    data['url'] = this.url;
    data['autoscroll'] = this.autoscroll;
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
  String totalquota;
  String jenis;
  String header;
  String headerS;
  String autoscroll;

  Tutorial(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.totalquota,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll});

  Tutorial.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    totalquota = json['totalquota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['totalquota'] = this.totalquota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
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
  String totalquota;
  String jenis;
  String header;
  String headerS;
  String autoscroll;

  Qscreen(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.totalquota,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll});

  Qscreen.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    totalquota = json['totalquota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['totalquota'] = this.totalquota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
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
  String totalquota;
  String jenis;
  String header;
  String headerS;
  String autoscroll;

  Qsurvey(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.totalquota,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll});

  Qsurvey.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    totalquota = json['totalquota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['totalquota'] = this.totalquota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
    return data;
  }
}

class Qpolling {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String quota;
  String totalquota;
  String jenis;
  String header;
  String headerS;
  String autoscroll;

  Qpolling(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.totalquota,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll});

  Qpolling.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    totalquota = json['totalquota'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['quota'] = this.quota;
    data['totalquota'] = this.totalquota;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
    return data;
  }
}

class Qgames {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String jenis;
  String header;
  String headerS;
  String autoscroll;

  Qgames(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll});

  Qgames.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
    return data;
  }
}

class Qnews {
  String judul;
  String deskripsi;
  String id;
  String color;
  String gambar;
  String jenis;
  String header;
  String headerS;
  String autoscroll;

  Qnews(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll});

  Qnews.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['id'] = this.id;
    data['color'] = this.color;
    data['gambar'] = this.gambar;
    data['jenis'] = this.jenis;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
    return data;
  }
}


