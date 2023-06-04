import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/widget/round_button.dart';
import 'package:flutter/material.dart';
class AddFirestroreDataScreen extends StatefulWidget {
  const AddFirestroreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestroreDataScreen> createState() => _AddFirestroreDataScreenState();
}

class _AddFirestroreDataScreenState extends State<AddFirestroreDataScreen> {
  final todoController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Add Data"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: todoController,
              decoration: InputDecoration(
                hintText: "Add Todo",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 70,),
            RoundButton(
              loading: loading,
                title: "Add to FireStore", onpress: (){
                  setState(() {
                    loading=true;
                  });
                  String id = DateTime.now().millisecond.toString();
                  fireStore.doc(id).set({
                    'title':todoController.text.toString(),
                    'id':id,

                  }).then((value) {
                    Utils().toastMessege("Added to Firestore");
                    setState(() {
                      loading= false;
                    });

                  }).onError((error, stackTrace) {
                    setState(() {
                      loading= false;
                    });
                    Utils().toastMessege(error.toString());
                  });

            })

          ],
        ),
      ),
    );
  }
}
