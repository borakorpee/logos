class Online_Psycs_Model {
  bool? status;
  String? message;
  List<Psychologist>? psychologist;

  Online_Psycs_Model({this.status, this.message, this.psychologist});

  Online_Psycs_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['psychologist'] != null) {
      psychologist = <Psychologist>[];
      json['psychologist'].forEach((v) {
        psychologist!.add(new Psychologist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.psychologist != null) {
      data['psychologist'] = this.psychologist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Psychologist {
  String? sId;
  String? name;
  String? surName;
  String? pass;
  String? eMail;
  List<String>? tag;
  String? unvan;
  String? createAt;
  int? iV;
  List<num>? star;
  List<num>? starAvg;
  String? updateAt;
  bool? active;
  String? image;
  String? tecrube;

  Psychologist(
      {this.sId,
      this.name,
      this.surName,
      this.pass,
      this.eMail,
      this.tag,
      this.unvan,
      this.createAt,
      this.iV,
      this.star,
      this.starAvg,
      this.updateAt,
      this.active,
      this.image,
      this.tecrube});

  Psychologist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    surName = json['surName'];
    pass = json['pass'];
    eMail = json['eMail'];
    tag = json['tag'].cast<String>();
    unvan = json['unvan'];
    createAt = json['createAt'];
    iV = json['__v'];
    star = json['star'].cast<num>();
    starAvg = json['starAvg'].cast<num>();
    updateAt = json['updateAt'];
    active = json['active'];
    image = json['image'];
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
    data['createAt'] = this.createAt;
    data['__v'] = this.iV;
    data['star'] = this.star;
    data['starAvg'] = this.starAvg;
    data['updateAt'] = this.updateAt;
    data['active'] = this.active;
    data['image'] = this.image;
    data['tecrube'] = this.tecrube;
    return data;
  }
}
