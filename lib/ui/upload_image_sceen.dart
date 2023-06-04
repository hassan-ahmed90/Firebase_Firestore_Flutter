import 'dart:io';


import 'package:firebase_class/Utils/utils.dart';
import 'package:firebase_class/widget/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference  = FirebaseDatabase.instance.ref('Post');
  bool loading = false;
  Future getGalleryImage()async{
    final pickedFile = await  picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile!= null){
        _image=File(pickedFile.path);
      }else{
        print('file not picked');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent ,
        title: Text('Image Uploader'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(child: InkWell(
              onTap: (){
                getGalleryImage();
              },
              child: Container(
                child: _image!=null? Image.file(_image!.absolute):Icon(Icons.image),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                  )
                ),
              ),
            ),),
            SizedBox(height: 60,),
            RoundButton(
                loading: loading,
                title: 'Upload', onpress: ()async{
              setState(() {
                loading=true;
              });

              firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.ref('/DCIM'+'900');
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
              await Future.value(uploadTask);
              var newUrl = await  ref.getDownloadURL();
              databaseReference.child('1').set({
                'id': '129',
                'title': newUrl.toString(),
              }).then((value) {
                setState(() {
                  loading=false;
                });
                Utils().toastMessege("Uploaded");
              }).onError((error, stackTrace) {
                setState(() {
                  loading = false;
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
