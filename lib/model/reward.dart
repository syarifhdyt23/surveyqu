class HistoryReward {
  String judul;
  String isi;
  String id;
  String surveyDate;
  String nominal;

  HistoryReward({this.judul, this.isi, this.id, this.surveyDate, this.nominal});

  HistoryReward.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    id = json['id'];
    surveyDate = json['survey_date'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['id'] = this.id;
    data['survey_date'] = this.surveyDate;
    data['nominal'] = this.nominal;
    return data;
  }
}

class HistoryTarik {
  String judul;
  String isi;
  String id;
  String surveyDate;
  String nominal;

  HistoryTarik({this.judul, this.isi, this.id, this.surveyDate, this.nominal});

  HistoryTarik.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    isi = json['isi'];
    id = json['id'];
    surveyDate = json['survey_date'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['id'] = this.id;
    data['survey_date'] = this.surveyDate;
    data['nominal'] = this.nominal;
    return data;
  }
}