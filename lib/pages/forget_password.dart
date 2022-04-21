
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helper/constant.dart';
import '../helper/http_helper.dart';
import '../model/userModel.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _userId = TextEditingController();
  final _mobile = TextEditingController();
  final _password = TextEditingController();

  reset() async {
    String userId = _userId.value.text;
    String mobile = _mobile.value.text;
    String password = _password.value.text;

    var model = UserModel(
        userId: int.parse(userId), mobile: mobile, password: password);


    reset(UserModel user) async {
      String userId = _userId.value.text;
      String mobile = _mobile.value.text;
      String password = _password.value.text;

      var user = UserModel(
          userId: int.parse(userId), mobile: mobile, password: password);

      reset(user).then((res) {
        Map<String, dynamic> map = jsonDecode(res.body);
        print(map['status']);
        if (map['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Login Sucsess",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Login Failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        toolbarHeight: 80,
        title: const Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.indigo,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Text(
                  "Enter your userid and mobile no. and reset your password",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,

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
                      return 'Please enter your password';
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
                    reset();
                    print(_userId.value.text);
                  },
                  child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
