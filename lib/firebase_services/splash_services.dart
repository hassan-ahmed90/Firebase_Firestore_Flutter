import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/ui/post/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';

class SplashServices{


  void isLogin(BuildContext context)async {

    final  auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      });
    }else{
      Timer(Duration(seconds: 3), () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      });
    }
  

  }
}