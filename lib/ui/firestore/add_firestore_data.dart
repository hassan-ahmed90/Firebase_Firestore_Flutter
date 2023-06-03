import 'package:firebase_class/widget/round_button.dart';
import 'package:flutter/material.dart';
class AddFirestroreDataScreen extends StatefulWidget {
  const AddFirestroreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestroreDataScreen> createState() => _AddFirestroreDataScreenState();
}

class _AddFirestroreDataScreenState extends State<AddFirestroreDataScreen> {
  final todoController = TextEditingController();
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
                title: "Add to FireStore", onpress: (){

            })

          ],
        ),
      ),
    );
  }
}
