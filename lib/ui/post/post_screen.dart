import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/ui/auth/login_screen.dart';
import 'package:firebase_class/ui/post/add_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final ref =FirebaseDatabase.instance.ref("Post");
  final filterCOntroller = TextEditingController();
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
          SizedBox(height: 20,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15,
          ),child: TextFormField(
            controller: filterCOntroller,
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder()
            ),
            onChanged: (String value){
              setState(() {

              });
            },
          ),
          ),

          Expanded(child: FirebaseAnimatedList(
            defaultChild: Text("Loading"),
            query: ref,
            itemBuilder: (context,snapshot,animation,index){

              final name =  snapshot.child('name').value.toString();
              if(filterCOntroller.text.isEmpty){
                return ListTile(
                  title: Text(snapshot.child("name").value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                );

              }else if(name.toLowerCase().contains(filterCOntroller.text.toLowerCase().toLowerCase())){
                return ListTile(
                  title: Text(snapshot.child("name").value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                );
              }
              else{
               return Container();
              }
            },
          ))

        ],
      ) ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPost()));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
// Expanded(child: StreamBuilder(
// stream: ref.onValue,
// builder: (
// context,AsyncSnapshot<DatabaseEvent> snapshot){
// if(!snapshot.hasData){
// return CircularProgressIndicator();
// }else{
// Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic ;
// List <dynamic> list =[];
// list.clear();
// list = map.values.toList();
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (context,index){
// return ListTile(
// title: Text(list[index]['name']),
// subtitle: Text(list[index]['id']),
// );
//
// });
// }
// },
// )),
