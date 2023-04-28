class ReservationsModel {
  bool? status;
  String? message;
  int? total;
  List<Reservation>? reservation;

  ReservationsModel({this.status, this.message, this.total, this.reservation});

  ReservationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['reservation'] != null) {
      reservation = <Reservation>[];
      json['reservation'].forEach((v) {
        reservation!.add(new Reservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservation {
  String? sId;
  String? day;
  String? time;
  PsycId? psycId;
  ClientId? clientId;
  int? type;

  Reservation(
      {this.sId, this.day, this.time, this.psycId, this.clientId, this.type});

  Reservation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    time = json['time'];
    psycId =
        json['psyc_id'] != null ? new PsycId.fromJson(json['psyc_id']) : null;
    clientId = json['client_id'] != null
        ? new ClientId.fromJson(json['client_id'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['day'] = this.day;
    data['time'] = this.time;
    if (this.psycId != null) {
      data['psyc_id'] = this.psycId!.toJson();
    }
    if (this.clientId != null) {
      data['client_id'] = this.clientId!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class PsycId {
  String? sId;
  String? unvan;
  String? name;
  String? surName;
  List<String>? tag;
  String? image;

  PsycId({this.sId, this.unvan, this.name, this.surName, this.tag, this.image});

  PsycId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    unvan = json['unvan'];
    name = json['name'];
    surName = json['surName'];
    tag = json['tag'].cast<String>();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['unvan'] = this.unvan;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['tag'] = this.tag;
    data['image'] = this.image;
    return data;
  }
}

class ClientId {
  String? sId;
  String? name;
  String? surName;
  String? dateOfBirth;
  String? sex;
  String? image;

  ClientId(
      {this.sId,
      this.name,
      this.surName,
      this.dateOfBirth,
      this.sex,
      this.image});

  ClientId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    surName = json['surName'];
    dateOfBirth = json['dateOfBirth'];
    sex = json['sex'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['sex'] = this.sex;
    data['image'] = this.image;
    return data;
  }
}
