import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_2/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../utility/utils.dart';
class UploadimageScreen extends StatefulWidget {
  const UploadimageScreen({Key? key}) : super(key: key);

  @override
  State<UploadimageScreen> createState() => _UploadimageScreenState();
}

class _UploadimageScreenState extends State<UploadimageScreen> {
  @override

  File? _image;
  final picker=ImagePicker();
  DatabaseReference firebaseRef =FirebaseDatabase.instance.ref("posts");
firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  Future GetGalleryImage () async{

    final pickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile!=null){
_image=File(pickedFile.path);

      }else
        {
          print("Picked");
        }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text("Upload Image"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: InkWell(
                onTap: (){
                  GetGalleryImage();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width:3,color: Colors.orange.shade300)
                  ),
                  child: Center(
                    child: _image!=null ? Image.file(_image!.absolute): Icon(Icons.image),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Roundbutton(title: "Upload", onTap: () async{

                firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.ref('/images/'+DateTime.now().microsecondsSinceEpoch.toString());
firebase_storage.UploadTask uploadTask=ref.putFile(_image!.absolute);
await Future.value(uploadTask);
var newUrl= await ref.getDownloadURL();

firebaseRef.child('1').set({
  'id':'Unique Id',
  'title':newUrl.toString()

}).onError((error, stackTrace) {
  Utils().toastmessege(error.toString(), Colors.orange.shade200);
});

Utils().toastmessege('Succesfully Uploaded', Colors.orange.shade200);

              } ,colour: Colors.orange.shade300),
            )
          ],
        ),
      ),
    );
  }
}
