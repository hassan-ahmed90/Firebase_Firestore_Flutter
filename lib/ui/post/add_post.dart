import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/widget/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Add Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What's in your mind",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(
              loading: loading,
              title: "Add ",onpress: (){
                setState(() {
                  loading=true;
                });
              databaseRef.child(DateTime.now().millisecond.toString()).set({
              'id':DateTime.now().millisecond.toString(),
                'name':postController.text.toString(),
              }).then((value){
                setState(() {
                  loading=false;
                });
                Utils().toastMessege("Added Post");
              }).onError((error, stackTrace) {
                Utils().toastMessege("Cannot be added");

              });
            },)
          ],
        ),
      ),
    );
  }
}
