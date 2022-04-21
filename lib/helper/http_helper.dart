

import 'dart:convert';


import 'package:flutter_app/model/userModel.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
};

Future<http.Response> signUp(UserModel user) async {
  final response = await http.post(Uri.parse(registerApi),
      headers: requestHeaders, body: jsonEncode(user.toMap()));

  return response;
}


Future<http.Response> signIn(UserModel user) async {
  final response = await http.post(Uri.parse(userLoginApi),
      headers: requestHeaders, body: jsonEncode(user.toMap()));
  return response;
}





Future<http.Response> reset(UserModel user) async {
  final response = await http.post(Uri.parse(resetPasswordApi),
      headers: requestHeaders, body: jsonEncode(user.toMap()));
  return response;
}




Future<http.Response> updatePass() async {
  final response =  await http.put(Uri.parse(updatePasswordApi), headers: requestHeaders);
  return response;
}

