class ResultQ {
  int status;
  List<Result> result;

  ResultQ({this.status, this.result});

  ResultQ.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String id;
  String question;
  String type;
  List<dynamic> opsi;
  String urutan;

  Result({this.id, this.question, this.type, this.opsi, this.urutan});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    type = json['type'];
    opsi = json['opsi'] == '' ? null : json['opsi'].map((item) => item as String)?.toList();
    urutan = json['urutan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['type'] = this.type;
    data['opsi'] = this.opsi;
    data['urutan'] = this.urutan;
    return data;
  }
}

class nextQ {
  int status;
  String id;
  String urutan;
  String message;

  nextQ(
      {this.status,
        this.id,
        this.urutan,
        this.message});

  nextQ.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    urutan = json['urutan'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['urutan'] = this.urutan;
    data['message'] = this.message;
    return data;
  }
}

class prevQ {
  int status;
  String id;
  String urutan;
  String message;

  prevQ(
      {this.status,
        this.id,
        this.urutan,
        this.message});

  prevQ.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    urutan = json['urutan'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['urutan'] = this.urutan;
    data['message'] = this.message;
    return data;
  }
}

class HeaderSurvey {
  String id;
  String subJudul;
  String deskripsi;
  String status;
  String rewards;

  HeaderSurvey({this.id, this.subJudul, this.deskripsi, this.status, this.rewards});

  HeaderSurvey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subJudul = json['sub_judul'];
    deskripsi = json['deskripsi'];
    status = json['status'];
    rewards = json['rewards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_judul'] = this.subJudul;
    data['deskripsi'] = this.deskripsi;
    data['status'] = this.status;
    data['rewards'] = this.rewards;
    return data;
  }
}

class ResultQnews {
  String id;
  String judul;
  String deskripsi;
  String urutan;

  ResultQnews({this.id, this.judul, this.deskripsi, this.urutan});

  ResultQnews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    urutan = json['urutan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['urutan'] = this.urutan;
    return data;
  }
}

class SurveyRes {
  String id;
  String question;
  String type;
  String opsi;
  String urutan;
  String jumlah;
  String total;
  String j1;
  String j2;
  String j3;
  String j4;

  SurveyRes(
      {this.id,
        this.question,
        this.type,
        this.opsi,
        this.urutan,
        this.jumlah,
        this.total,
        this.j1,
        this.j2,
        this.j3,
        this.j4});

  SurveyRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    type = json['type'];
    opsi = json['opsi'];
    urutan = json['urutan'];
    jumlah = json['jumlah'];
    total = json['total'];
    j1 = json['j1'];
    j2 = json['j2'];
    j3 = json['j3'];
    j4 = json['j4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['type'] = this.type;
    data['opsi'] = this.opsi;
    data['urutan'] = this.urutan;
    data['jumlah'] = this.jumlah;
    data['total'] = this.total;
    data['j1'] = this.j1;
    data['j2'] = this.j2;
    data['j3'] = this.j3;
    data['j4'] = this.j4;
    return data;
  }
}