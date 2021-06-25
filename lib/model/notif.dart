class NotifDetail {
  String isi;
  String stsNotif;

  NotifDetail({this.isi, this.stsNotif});

  NotifDetail.fromJson(Map<String, dynamic> json) {
    isi = json['isi'];
    stsNotif = json['sts_notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    return data;
  }
}

class HistorySurvey {
  String isi;
  String stsNotif;

  HistorySurvey({this.isi, this.stsNotif});

  HistorySurvey.fromJson(Map<String, dynamic> json) {
    isi = json['isi'];
    stsNotif = json['sts_notif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isi'] = this.isi;
    data['sts_notif'] = this.stsNotif;
    return data;
  }
}