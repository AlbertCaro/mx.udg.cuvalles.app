import 'package:CUValles/values/functions.dart';

class User {
  String code, name, career;

  User({this.code, this.name, this.career});

  User.fromJSON(Map json) :
    code = json[''],
    name = json[''],
    career = json[''];

  static Future consultAPI() async {
    return jsonRequest("");
  }

  
}