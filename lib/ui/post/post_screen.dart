import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: (){
                
                _auth.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()))
                ).onError((error, stackTrace) => Utils().toastMessege(error.toString()));
                
              },
              child: Icon(Icons.logout)),
          SizedBox(width: 15,),
        ],
        centerTitle: true,
        title: Text("Post Screen"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [

        ],
      ) ,
    );
  }
}
