class SliderContent {
  int status;
  String message;
  List<String> content;
  List<String> urutan;

  SliderContent({this.status, this.message, this.content, this.urutan});

  factory SliderContent.fromJson(Map<String, dynamic> parsedJson) {
    return new SliderContent(
      status : parsedJson['status'],
      message : parsedJson['message'],
      content : parsedJson['content'].cast<String>(),
      urutan : parsedJson['urutan'].cast<String>()
    );
  }

  // SliderContent.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   message = json['message'];
  //   content = json['content'].cast<String>();
  //   urutan = json['urutan'].cast<String>();
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   data['content'] = this.content;
  //   data['urutan'] = this.urutan;
  //   return data;
  // }
}
