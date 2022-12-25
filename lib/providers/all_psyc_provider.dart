// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logos/models/all_psyc_model.dart';

class All_Psychologists_Provider with ChangeNotifier {
  All_Psyc_Model _pscys = All_Psyc_Model(
    status: null,
    message: '',
    psychologists: [],
  );
  List<Psychologists> filtered_list = [];

  All_Psyc_Model get all_Psycs => _pscys;
  List<Psychologists>? get psyc_list => _pscys.psychologists;

  void setPsycs(dynamic all_psycs) {
    _pscys = All_Psyc_Model.fromJson(jsonDecode(all_psycs));

    notifyListeners();
  }

  List<Psychologists>? filtered_psycs(
    List filterlist,
  ) {
    filtered_list = [];
    for (var filter in filterlist) {
      psyc_list?.forEach((element) {
        if (element.tag?.contains(filter) == true) {
          filtered_list.add(element);
        }
      });
    }
    filtered_list = filtered_list.toSet().toList();
    notifyListeners();

    return filtered_list;
  }

  Psychologists findById(String id) {
    return _pscys.psychologists!.firstWhere((psycs) => psycs.sId == id);
  }
}
