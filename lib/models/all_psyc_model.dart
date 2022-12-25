// ignore_for_file: camel_case_types, unnecessary_new, prefer_collection_literals

class All_Psyc_Model {
  bool? status;
  String? message;
  List<Psychologists>? psychologists;

  All_Psyc_Model({this.status, this.message, this.psychologists});

  All_Psyc_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['psychologists'] != null) {
      psychologists = <Psychologists>[];
      json['psychologists'].forEach((v) {
        psychologists!.add(new Psychologists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (psychologists != null) {
      data['psychologists'] = psychologists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Psychologists {
  String? sId;
  String? name;
  String? surName;
  String? pass;
  String? eMail;
  List<String>? tag;
  String? unvan;
  String? about;
  String? createAt;
  int? iV;

  Psychologists(
      {this.sId,
      this.name,
      this.surName,
      this.pass,
      this.eMail,
      this.tag,
      this.unvan,
      this.about,
      this.createAt,
      this.iV});

  Psychologists.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    surName = json['surName'];
    pass = json['pass'];
    eMail = json['eMail'];
    tag = json['tag'].cast<String>();
    unvan = json['unvan'];
    about = json['about'];
    createAt = json['createAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['surName'] = surName;
    data['pass'] = pass;
    data['eMail'] = eMail;
    data['tag'] = tag;
    data['unvan'] = unvan;
    data['about'] = about;
    data['createAt'] = createAt;
    data['__v'] = iV;
    return data;
  }
}
