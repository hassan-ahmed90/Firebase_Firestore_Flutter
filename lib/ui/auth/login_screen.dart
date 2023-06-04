import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/ui/auth/login_with_phone.dart';
import 'package:firebase_class/ui/auth/signup_screen.dart';
import 'package:firebase_class/ui/forgot_screen.dart';
import 'package:firebase_class/ui/post/post_screen.dart';
import 'package:firebase_class/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _auth = FirebaseAuth.instance;
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
  void login(){

    setState(() {
      loading= true;
    });
    _auth.signInWithEmailAndPassword(email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
          setState(() {
            loading=false;
          });
       Utils().toastMessege(value.user!.email.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
    }).onError((error, stackTrace) {
      loading=false;
      debugPrint(error.toString());
      Utils().toastMessege(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
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
              RoundButton(
                loading: loading,
                title: "Log In",
                onpress: (){
                if(_formKey.currentState!.validate()){
                  login();
                }

              },),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetScreen()));
                }, child: Text('Forget Password'),),
              ),
              SizedBox(height: 20,),
              Row(children: [
                Text("Don't have an account"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                }, child: Text('SignUp'),)
                  ],),

              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPhone()));

              },child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black45)
                ),
                child: Center(child: Text("Login with Phone No"),
                ),
              ),)

            ],
          ),
        ),
      ),
    );
  }
}
