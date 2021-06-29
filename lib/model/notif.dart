class NotifDetail {
  String judul;
  String stsNotif;
  String id;

  NotifDetail({this.judul, this.stsNotif, this.id});

  NotifDetail.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    stsNotif = json['sts_notif'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['sts_notif'] = this.stsNotif;
    data['id'] = this.id;
    return data;
  }
}

class HistorySurvey {
  String judul;
  String stsNotif;
  String id;

  HistorySurvey({this.judul, this.stsNotif, this.id});

  HistorySurvey.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    stsNotif = json['sts_notif'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['sts_notif'] = this.stsNotif;
    data['id'] = this.id;
    return data;
  }
}

class NotifHit {
  String judul;
  String isi;
  String stsNotif;

  NotifHit({this.judul, this.isi, this.stsNotif});

  NotifHit.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    stsNotif = json['sts_notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    return data;
  }
}

class HistoryHit {
  String judul;
  String isi;
  String stsNotif;

  HistoryHit({this.judul, this.isi, this.stsNotif});

  HistoryHit.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    stsNotif = json['sts_notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    return data;
  }
}