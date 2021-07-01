class NotifDetail {
  String judul;
  String isi;
  String stsNotif;
  String id;

  NotifDetail({this.judul, this.isi, this.stsNotif, this.id});

  NotifDetail.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    stsNotif = json['sts_notif'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    data['id'] = this.id;
    return data;
  }
}

class HistorySurvey {
  String judul;
  String isi;
  String stsNotif;
  String id;

  HistorySurvey({this.judul, this.isi, this.stsNotif, this.id});

  HistorySurvey.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    stsNotif = json['sts_notif'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    data['id'] = this.id;
    return data;
  }
}