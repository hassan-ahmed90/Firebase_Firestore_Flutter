import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/ui/post/post_screen.dart';
import 'package:flutter/material.dart';

import '../../widget/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verification;
  VerifyCodeScreen({Key? key,required this.verification}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  final verificatonNoController = TextEditingController();
  final bool = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verificatoin Screen"),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verificatonNoController,
              decoration: InputDecoration(
                  hintText: "verificatoin code"

              ),
            ),
            SizedBox(height: 60,),
            RoundButton(title: "Verify", onpress: () async {

              final credential = PhoneAuthProvider.credential(verificationId: widget.verification, smsCode: verificatonNoController.text.toString());
              try{
                await auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
              }catch(e){

              }

            })

          ],
        ),
      ),
    );
  }}