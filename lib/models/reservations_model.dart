class ReservationsModel {
  bool? status;
  String? message;
  List<Reservation>? reservation;

  ReservationsModel({this.status, this.message, this.reservation});

  ReservationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reservation'] != null) {
      reservation = <Reservation>[];
      json['reservation'].forEach((v) {
        if (v != null) {
          reservation!.add(new Reservation.fromJson(v));
        }
        //reservation!.add(new Reservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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

  Reservation({this.sId, this.day, this.time, this.psycId});

  Reservation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    time = json['time'];
    psycId =
        json['psyc_id'] != null ? new PsycId.fromJson(json['psyc_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['day'] = this.day;
    data['time'] = this.time;
    if (this.psycId != null) {
      data['psyc_id'] = this.psycId!.toJson();
    }
    return data;
  }
}

class PsycId {
  String? sId;
  String? unvan;
  String? name;
  String? surName;
  List<String>? tag;

  PsycId({this.sId, this.unvan, this.name, this.surName, this.tag});

  PsycId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    unvan = json['unvan'];
    name = json['name'];
    surName = json['surName'];
    tag = json['tag'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['unvan'] = this.unvan;
    data['name'] = this.name;
    data['surName'] = this.surName;
    data['tag'] = this.tag;
    return data;
  }
}
