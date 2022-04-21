import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/signup_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helper/constant.dart';
import '../helper/http_helper.dart';
import '../model/userModel.dart';
import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userId = TextEditingController();
  final _password = TextEditingController();

  login() async {
    String userId = _userId.value.text;
    String password = _password.value.text;
    var user = UserModel(userId: int.parse(userId),mobile: '', password: password);
    print(user);

    signIn(user).then((res) {
      Map<String, dynamic> map = jsonDecode(res.body);

      print(map['status']);
      if (map['status'] == 'Success') {
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


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 3, top: 15),
              child: Text(
                "Login Here",
                style: TextStyle(
                    fontSize: 40,
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
                    return 'Please enter Your Password';
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
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              textColor: Colors.blue,
              child: Text('Forgot Password'),
            ),
            ElevatedButton(
                onPressed: () {
                  login();
                  print(_userId.value.text);
                },
                child: Text("Login")),
            Padding(
              padding: const EdgeInsets.only(
                left: 60.0,
              ),
              child: Row(
                children: [
                  Text('Does not have account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
                      },
                      child: Text("registration here")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
