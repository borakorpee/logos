// ignore_for_file: unused_import, prefer_collection_literals

import 'package:flutter/material.dart';

class ClientModel {
  bool? status;
  String? message;
  String? token;
  Client? client;

  ClientModel(
      {required this.status,
      required this.message,
      required this.token,
      required this.client});

  ClientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (client != null) {
      data['client'] = client!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['surName'] = surName;
    data['pass'] = pass;
    data['eMail'] = eMail;
    data['dateOfBirth'] = dateOfBirth;
    data['city'] = city;
    data['county'] = county;
    data['job'] = job;
    data['sex'] = sex;
    data['createAt'] = createAt;
    data['__v'] = iV;
    return data;
  }
}
