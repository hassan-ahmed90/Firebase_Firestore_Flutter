import 'package:firebase_class/widget/round_button.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            RoundButton(title: "Log In",
              onpress: (){
              if(_formKey.currentState!.validate()){

              }

            },)

          ],
        ),
      )
    );
  }
}
