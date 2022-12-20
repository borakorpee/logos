import 'package:logos/models/client_model.dart';
import 'package:logos/service/auth_service.dart';

class LoggedClient {
  String? id;
  String? name;
  String? pass;
  String? email;
  DateTime? dateOfBirth;

  LoggedClient({this.id, this.name, this.pass, this.dateOfBirth});
}
