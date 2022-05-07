import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/http_helper.dart';
import 'package:flutter_app/model/userModel.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

import '../helper/constant.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _userId = TextEditingController();
  final _mobile = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  save() async {
    String userId = _userId.value.text;
    String mobile = _mobile.value.text;
    String password = _password.value.text;

    var user = UserModel(
        userId: int.parse(userId), mobile: mobile, password: password);
    signUp(user).then((res) {
      Map<String, dynamic> map = jsonDecode(res.body);
      if (map['status'] == 200) {
        Fluttertoast.showToast(
            msg: "data save Sucsess",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "data save failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        toolbarHeight: 80,
        title: const Text(
          "Signup Page",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3, top: 15),
                    child: Text(
                      "Signup Here",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter User ID';
                        }
                        return null;
                      },
                      controller: _userId,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.mark_email_read,
                            size: 20.0,
                          ),
                          border: UnderlineInputBorder(),
                          labelText: "Enter your User Id"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Mobile Number';
                        }
                        return null;
                      },
                      controller: _mobile,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.phone,
                            size: 20.0,
                          ),
                          border: UnderlineInputBorder(),
                          labelText: "Enter phone no."),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input your new Password';
                        }
                        return null;
                      },
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.password_outlined,
                            size: 20.0,
                          ),
                          border: UnderlineInputBorder(),
                          labelText: "Enter your Password"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          save();
                        }
                      },
                      child: Text("signup")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
