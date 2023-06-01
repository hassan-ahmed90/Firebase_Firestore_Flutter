import 'package:firebase_class/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
SplashServices splashServices = SplashServices();
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Firebase Fanta",style: TextStyle(fontSize: 40,color: Colors.orange,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
