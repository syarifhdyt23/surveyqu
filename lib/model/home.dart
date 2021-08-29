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
  String rewards;

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
        this.autoscroll,
      this.rewards});

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
    rewards = json['rewards'];
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
    data['rewards'] = this.rewards;
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
  String urutan;
  String rewards;

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
        this.autoscroll,
        this.urutan,
      this.rewards});

  Qscreen.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    totalquota = json['totalquota'];
    urutan = json['urutan'];
    jenis = json['jenis'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
    urutan = json['urutan'];
    rewards = json['rewards'];
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
    data['rewards'] = this.rewards;
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
  String rewards;

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
        this.autoscroll,
      this.rewards});

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
    rewards = json['rewards'];
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
    data['rewards'] = this.rewards;
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
  String urutan;
  String header;
  String headerS;
  String autoscroll;
  String rewards;
  String status_result;

  Qpolling(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.quota,
        this.totalquota,
        this.jenis,
        this.urutan,
        this.header,
        this.headerS,
        this.autoscroll,
      this.rewards,
      this.status_result});

  Qpolling.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    id = json['id'];
    color = json['color'];
    gambar = json['gambar'];
    quota = json['quota'];
    totalquota = json['totalquota'];
    jenis = json['jenis'];
    urutan = json['urutan'];
    header = json['header'];
    headerS = json['headerS'];
    autoscroll = json['autoscroll'];
    rewards = json['rewards'];
    status_result = json['status_result'];
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
    data['urutan'] = this.urutan;
    data['header'] = this.header;
    data['headerS'] = this.headerS;
    data['autoscroll'] = this.autoscroll;
    data['rewards'] = this.rewards;
    data['status_result'] = this.status_result;
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
  String rewards;

  Qgames(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll,
      this.rewards});

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
    rewards = json['rewards'];
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
    data['rewards'] = this.rewards;
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
  String rewards;

  Qnews(
      {this.judul,
        this.deskripsi,
        this.id,
        this.color,
        this.gambar,
        this.jenis,
        this.header,
        this.headerS,
        this.autoscroll,
      this.rewards});

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
    rewards = json['rewards'];
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
    data['rewards'] = this.rewards;
    return data;
  }
}


