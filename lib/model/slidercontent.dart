// To parse this JSON data, do
//
//     final slidercontent = slidercontentFromJson(jsonString);

import 'dart:convert';

Slidercontent slidercontentFromJson(String str) => Slidercontent.fromJson(json.decode(str));

String slidercontentToJson(Slidercontent data) => json.encode(data.toJson());

class Slidercontent {
  Slidercontent({
    this.status,
    this.message,
    this.content,
  });

  int status;
  String message;
  List<Content> content;

  factory Slidercontent.fromJson(Map<String, dynamic> json) => Slidercontent(
    status: json["status"],
    message: json["message"],
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  Content({
    this.konten,
    this.urutan,
    this.img,
  });

  String konten;
  String urutan;
  String img;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    konten: json["konten"],
    urutan: json["urutan"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "konten": konten,
    "urutan": urutan,
    "img": img,
  };
}
