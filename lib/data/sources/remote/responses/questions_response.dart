import 'dart:convert';

class GetQuestionsResponse {
  int? code;
  String? status;
  String? message;
  List<GetQuestionsResponseDatum>? data;

  GetQuestionsResponse({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory GetQuestionsResponse.fromJson(String str) => GetQuestionsResponse.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory GetQuestionsResponse.fromMap(Map<String, dynamic> json) => GetQuestionsResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<GetQuestionsResponseDatum>.from(json["data"]!.map((x) => GetQuestionsResponseDatum.fromMap(x))),
      );

  // Map<String, dynamic> toMap() => {
  //       "code": code,
  //       "status": status,
  //       "message": message,
  //       "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  //     };
}

class GetQuestionsResponseDatum {
  dynamic question;
  dynamic questionnumber;
  String? typequestion;
  String? name;
  String? value;
  int? grade;
  dynamic data;

  GetQuestionsResponseDatum({
    this.question,
    this.questionnumber,
    this.typequestion,
    this.name,
    this.value,
    this.grade,
    this.data,
  });

  factory GetQuestionsResponseDatum.fromJson(String str) => GetQuestionsResponseDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatum.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatum(
        question: json["question"],
        questionnumber: json["questionnumber"],
        typequestion: json["typequestion"],
        name: json["name"],
        value: json["value"],
        grade: json["grade"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "questionnumber": questionnumber,
        "typequestion": typequestion,
        "name": name,
        "value": value,
        "grade": grade,
        "data": data,
      };
}

class GetQuestionsResponseDatumDataDatum {
  String? text;
  String? name;
  String? value;

  GetQuestionsResponseDatumDataDatum({
    this.text,
    this.name,
    this.value,
  });

  factory GetQuestionsResponseDatumDataDatum.fromJson(String str) =>
      GetQuestionsResponseDatumDataDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatumDataDatum.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatumDataDatum(
        text: json["text"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "name": name,
        "value": value,
      };
}

class GetQuestionsResponseDatumDataClass {
  List<GetQuestionsResponseDatumDataimage>? dataimage;
  List<GetQuestionsResponseDatumDataplace>? dataplace;
  List<GetQuestionsResponseDatumDatachoice>? datachoice;
  List<String>? dataoptions;
  List<GetQuestionsResponseDatumDatatext>? datatext;

  GetQuestionsResponseDatumDataClass({
    this.dataimage,
    this.dataplace,
    this.datachoice,
    this.dataoptions,
    this.datatext,
  });

  factory GetQuestionsResponseDatumDataClass.fromJson(String str) =>
      GetQuestionsResponseDatumDataClass.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatumDataClass.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatumDataClass(
        dataimage: json["dataimage"] == null
            ? null
            : List<GetQuestionsResponseDatumDataimage>.from(
                json["dataimage"]!.map((x) => GetQuestionsResponseDatumDataimage.fromMap(x))),
        dataplace: json["dataplace"] == null
            ? null
            : List<GetQuestionsResponseDatumDataplace>.from(
                json["dataplace"]!.map((x) => GetQuestionsResponseDatumDataplace.fromMap(x))),
        datachoice: json["datachoice"] == null
            ? null
            : List<GetQuestionsResponseDatumDatachoice>.from(
                json["datachoice"]!.map((x) => GetQuestionsResponseDatumDatachoice.fromMap(x))),
        dataoptions: json["dataoptions"] == null ? null : List<String>.from(json["dataoptions"]),
        datatext: json["datatext"] == null
            ? null
            : List<GetQuestionsResponseDatumDatatext>.from(
                json["datatext"]!.map((x) => GetQuestionsResponseDatumDatatext.fromMap(x))),
      );

  // Map<String, dynamic> toMap() => {
  //       "dataimage": dataimage == null ? null : List<dynamic>.from(dataimage!.map((x) => x.toMap())),
  //       "dataplace": dataplace == null ? null : List<dynamic>.from(dataplace!.map((x) => x.toMap())),
  //       "datachoice": datachoice == null ? null : List<dynamic>.from(datachoice!.map((x) => x.toMap())),
  //       "dataoptions": dataoptions == null ? null : List<dynamic>.from(dataoptions!.map((x) => x)),
  //       "datatext": datatext == null ? null : List<dynamic>.from(datatext!.map((x) => x.toMap())),
  //     };
}

class GetQuestionsResponseDatumDatachoice {
  String? name;
  int? value;

  GetQuestionsResponseDatumDatachoice({
    this.name,
    this.value,
  });

  factory GetQuestionsResponseDatumDatachoice.fromJson(String str) =>
      GetQuestionsResponseDatumDatachoice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatumDatachoice.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatumDatachoice(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "value": value,
      };
}

class GetQuestionsResponseDatumDataimage {
  String? urlimage;
  int? slot;

  GetQuestionsResponseDatumDataimage({
    this.urlimage,
    this.slot,
  });

  factory GetQuestionsResponseDatumDataimage.fromJson(String str) =>
      GetQuestionsResponseDatumDataimage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatumDataimage.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatumDataimage(
        urlimage: json["urlimage"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "urlimage": urlimage,
        "slot": slot,
      };
}

class GetQuestionsResponseDatumDataplace {
  String? name;
  String? value;

  GetQuestionsResponseDatumDataplace({
    this.name,
    this.value,
  });

  factory GetQuestionsResponseDatumDataplace.fromJson(String str) =>
      GetQuestionsResponseDatumDataplace.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatumDataplace.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatumDataplace(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "value": value,
      };
}

class GetQuestionsResponseDatumDatatext {
  String? text;
  String? name;
  dynamic value;

  GetQuestionsResponseDatumDatatext({
    this.text,
    this.name,
    this.value,
  });

  factory GetQuestionsResponseDatumDatatext.fromJson(String str) =>
      GetQuestionsResponseDatumDatatext.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetQuestionsResponseDatumDatatext.fromMap(Map<String, dynamic> json) => GetQuestionsResponseDatumDatatext(
        text: json["text"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "name": name,
        "value": value,
      };
}
