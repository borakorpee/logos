class top_psyc_model {
  bool? status;
  List<Result>? result;

  top_psyc_model({this.status, this.result});

  top_psyc_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? name;
  String? surName;
  String? pass;
  String? eMail;
  List<String>? tag;
  String? unvan;
  String? about;
  String? createAt;
  String? updateAt;
  int? iV;
  List<num>? star;
  List<num>? starAvg;
  String? tecrube;
  bool? active;
  String? image;

  Result(
      {this.sId,
      this.name,
      this.surName,
      this.pass,
      this.eMail,
      this.tag,
      this.unvan,
      this.about,
      this.createAt,
      this.updateAt,
      this.iV,
      this.star,
      this.starAvg,
      this.tecrube,
      this.active,
      this.image});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    surName = json['surName'];
    pass = json['pass'];
    eMail = json['eMail'];
    tag = json['tag'].cast<String>();
    unvan = json['unvan'];
    about = json['about'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    iV = json['__v'];
    star = json['star'].cast<num>();
    starAvg = json['starAvg'].cast<num>();
    tecrube = json['tecrube'];
    active = json['active'];
    image = json['image'];
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
    data['updateAt'] = this.updateAt;
    data['__v'] = this.iV;
    data['star'] = this.star;
    data['starAvg'] = this.starAvg;
    data['tecrube'] = this.tecrube;
    data['active'] = this.active;
    data['image'] = this.image;
    return data;
  }
}
