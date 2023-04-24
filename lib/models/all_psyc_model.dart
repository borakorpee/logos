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
  String? image;
  String? unvan;
  String? tecrube;
  List<int>? star;
  List<int>? starAvg;
  bool? active;
  bool? accActive;
  String? createAt;
  String? updateAt;
  int? iV;

  Psychologists(
      {this.sId,
      this.name,
      this.surName,
      this.pass,
      this.eMail,
      this.tag,
      this.image,
      this.unvan,
      this.tecrube,
      this.star,
      this.starAvg,
      this.active,
      this.accActive,
      this.createAt,
      this.updateAt,
      this.iV});

  Psychologists.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    surName = json['surName'];
    pass = json['pass'];
    eMail = json['eMail'];
    tag = json['tag'].cast<String>();
    image = json['image'];
    unvan = json['unvan'];
    tecrube = json['tecrube'];
    star = json['star'].cast<int>();
    starAvg = json['starAvg'].cast<int>();
    active = json['active'];
    accActive = json['accActive'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['pass'] = this.pass;
    data['eMail'] = this.eMail;
    data['tag'] = this.tag;
    data['image'] = this.image;
    data['unvan'] = this.unvan;
    data['tecrube'] = this.tecrube;
    data['star'] = this.star;
    data['starAvg'] = this.starAvg;
    data['active'] = this.active;
    data['accActive'] = this.accActive;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    data['__v'] = this.iV;
    return data;
  }
}
