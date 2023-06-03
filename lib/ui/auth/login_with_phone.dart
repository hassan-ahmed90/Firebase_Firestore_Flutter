import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/ui/auth/verify_code.dart';
import 'package:firebase_class/widget/round_button.dart';
import 'package:flutter/material.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {

 final phoneNoController = TextEditingController();
 final bool = false;
 final auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Phone"),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              // keyboardType: TextInputType.number,
              controller: phoneNoController,
              decoration: InputDecoration(
                hintText: "+92307-3069693"
                    
              ),
            ),
            SizedBox(height: 60,),
            RoundButton(title: "Login", onpress: (){
              
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNoController.text.toString(),
                  verificationCompleted: (_){},
                  verificationFailed: (e){Utils().toastMessege(e.toString());},
                  codeSent: (String verificationId,int? token){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCodeScreen(verification: verificationId,)));
                  },
                  codeAutoRetrievalTimeout: (e){Utils().toastMessege(e.toString());});

            })

          ],
        ),
      ),
    );
  }
}
