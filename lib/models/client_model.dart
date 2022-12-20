class ClientModel {
  bool? status;
  String? message;
  String? token;
  Client? client;

  ClientModel({this.status, this.message, this.token, this.client});

  ClientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  String? sId;
  String? name;
  String? surName;
  String? pass;
  String? eMail;
  String? dateOfBirth;
  String? city;
  String? county;
  String? job;
  String? sex;
  String? createAt;
  int? iV;

  Client(
      {this.sId,
      this.name,
      this.surName,
      this.pass,
      this.eMail,
      this.dateOfBirth,
      this.city,
      this.county,
      this.job,
      this.sex,
      this.createAt,
      this.iV});

  Client.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    surName = json['surName'];
    pass = json['pass'];
    eMail = json['eMail'];
    dateOfBirth = json['dateOfBirth'];
    city = json['city'];
    county = json['county'];
    job = json['job'];
    sex = json['sex'];
    createAt = json['createAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['pass'] = this.pass;
    data['eMail'] = this.eMail;
    data['dateOfBirth'] = this.dateOfBirth;
    data['city'] = this.city;
    data['county'] = this.county;
    data['job'] = this.job;
    data['sex'] = this.sex;
    data['createAt'] = this.createAt;
    data['__v'] = this.iV;
    return data;
  }
}
