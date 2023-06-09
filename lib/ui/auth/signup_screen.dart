import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/ui/auth/login_screen.dart';
import 'package:firebase_class/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {

  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final  passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Form(
              key: _formKey,
              child: Column(

                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Plz Enter the email";
                      }else
                        return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password",prefixIcon: Icon(Icons.lock)),

                    validator: (value){
                      if(value!.isEmpty){
                        return "Plz Enter the Password";
                      }else
                        return null;
                    },
                  ),

                ],
              ),

            ),

            SizedBox(height: 50,),
            RoundButton(title: "Sign In",
              loading: loading,
              onpress: (){
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading= true;
                  });
                  _auth.createUserWithEmailAndPassword(email: emailController.text.toString(),
                      password: passwordController.text.toString()
                  ).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    setState(() {
                      loading= false;
                    });


                  }).onError((error, stackTrace) {
                    setState(() {
                      loading= false;
                    });
                    Utils().toastMessege(error.toString());
                  });

                }

              },),
            SizedBox(height: 20,),
            Row(children: [
              Text("Already have an account"),
              TextButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }, child: Text('Login'),)
            ],)

          ],
        ),
      ),
    );
  }
}
