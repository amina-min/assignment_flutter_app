
import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        elevation: 8,
        toolbarHeight: 80, // default is 56
        title: const Text("User Login Page",textAlign: TextAlign.center,style: TextStyle(fontSize: 24,),),
        backgroundColor: Colors.indigo,
      ),
      body: LoginPage(

      ),
    ),
  ));
}

