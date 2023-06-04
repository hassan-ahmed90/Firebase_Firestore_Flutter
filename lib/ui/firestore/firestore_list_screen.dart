import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/ui/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>
              (
                stream: fireStore,
                builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot){
              return  Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(snapshot.hasError){
                          Utils().toastMessege("Cannot be Fetched ");
                        }
                        return ListTile(
                          onTap: (){
                            ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();
                          //   ref.doc(snapshot.data!.docs[index]['id'].toString()).update(
                          //       {
                          //         'title': " Updated"
                          //       }).then((value) {
                          //         Utils().toastMessege("Updated");
                          //   }).onError((error, stackTrace) {
                          //     Utils().toastMessege(error.toString());
                          //   });
                           },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }));
            }),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFirestroreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  // Future<void> showMyDialog(String name,String id)async{
  //   editingController.text=name;
  //   return showDialog(context: context, builder: (context){
  //     return AlertDialog(
  //       title: Text("Update"),
  //       content: Container(
  //         child: TextField(
  //           controller: editingController,
  //           decoration: InputDecoration(
  //               hintText: "Edit here"
  //           ),
  //         ),
  //       ),
  //       actions: [
  //
  //         TextButton(onPressed: (){
  //           Navigator.pop(context);
  //           ref.child(id).update({
  //             'name': editingController.text.toLowerCase(),
  //           }).then((value) {
  //             Utils().toastMessege("Updated Data");
  //           }).onError((error, stackTrace) {
  //             Utils().toastMessege("Cann't be updated");
  //           });
  //         }, child: Text("Update")),
  //         TextButton(onPressed: (){
  //           Navigator.pop(context);
  //         }, child: Text("Cancel")),
  //
  //       ],
  //     );
  //   });
  // }
}


