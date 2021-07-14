class HistoryReward {
  String judul;
  String isi;
  String stsNotif;
  String id;
  String nominal;
  String stsBayar;

  HistoryReward(
      {this.judul,
        this.isi,
        this.stsNotif,
        this.id,
        this.nominal,
        this.stsBayar});

  HistoryReward.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    stsNotif = json['sts_notif'];
    id = json['id'];
    nominal = json['nominal'];
    stsBayar = json['sts_bayar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    data['id'] = this.id;
    data['nominal'] = this.nominal;
    data['sts_bayar'] = this.stsBayar;
    return data;
  }
}

class HistoryTarik {
  String judul;
  String isi;
  String stsNotif;
  String id;
  String nominal;
  String stsBayar;

  HistoryTarik(
      {this.judul,
        this.isi,
        this.stsNotif,
        this.id,
        this.nominal,
        this.stsBayar});

  HistoryTarik.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    stsNotif = json['sts_notif'];
    id = json['id'];
    nominal = json['nominal'];
    stsBayar = json['sts_bayar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    data['id'] = this.id;
    data['nominal'] = this.nominal;
    data['sts_bayar'] = this.stsBayar;
    return data;
  }
}