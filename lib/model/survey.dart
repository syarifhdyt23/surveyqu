
class Question {
  int status;
  String id;
  String pertanyaan;
  String type;
  String opsi;
  String urutan;

  Question(
      {this.status,
        this.id,
        this.pertanyaan,
        this.type,
        this.opsi,
        this.urutan,});

  Question.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    pertanyaan = json['pertanyaan'];
    type = json['type'];
    opsi = json['opsi'];
    urutan = json['urutan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['pertanyaan'] = this.pertanyaan;
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

class Result {
  String id;
  String subJudul;
  String deskripsi;

  Result({this.id, this.subJudul, this.deskripsi});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subJudul = json['sub_judul'];
    deskripsi = json['deskripsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_judul'] = this.subJudul;
    data['deskripsi'] = this.deskripsi;
    return data;
  }
}