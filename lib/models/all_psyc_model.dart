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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.psychologists != null) {
      data['psychologists'] =
          this.psychologists!.map((v) => v.toJson()).toList();
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
  List<int>? star;
  String? updateAt;
  List<num>? starAvg;
  String? tecrube;

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
      this.iV,
      this.star,
      this.updateAt,
      this.starAvg,
      this.tecrube});

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
    star = json['star'].cast<int>();
    updateAt = json['updateAt'];
    starAvg = json['starAvg'].cast<num>();
    tecrube = json['tecrube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['pass'] = this.pass;
    data['eMail'] = this.eMail;
    data['tag'] = this.tag;
    data['unvan'] = this.unvan;
    data['about'] = this.about;
    data['createAt'] = this.createAt;
    data['__v'] = this.iV;
    data['star'] = this.star;
    data['updateAt'] = this.updateAt;
    data['starAvg'] = this.starAvg.toString();
    data['tecrube'] = this.tecrube;
    return data;
  }
}
