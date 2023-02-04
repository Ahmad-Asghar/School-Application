
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_2/firestore/firestorescreen.dart';
import 'package:firebase_project_2/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../utility/utils.dart';


class add_firestoredata extends StatefulWidget {
  final String Addinclass;

  const add_firestoredata({Key? key,
    required this.Addinclass,
  }) : super(key: key);

  @override
  State<add_firestoredata> createState() => _add_firestoredataState();
}

class _add_firestoredataState extends State<add_firestoredata> {

  @override
  void initState() {
    // TODO: implement initState
    print("path ="+imageFile.path);
    super.initState();
  }
  File imageFile=File("");
  bool uploading=false;
  selectImageSource(){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                onTap: (){
                  setState(() {
                  getImagefromGallery();
                  });
                  Navigator.pop(context);
                },
                leading: Icon(Icons.image),
                title: Text('Gallery'),
              ),
              ListTile(
                onTap: (){
                  setState(() {
                   getImagefromCamera();
                  });
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
              ),

            ],
          );
        }
    );
  }
  getImagefromCamera (){
    Future<void> _getFromGallery() async {

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path );
        });

      }
    }

    _getFromGallery();
  }
  getImagefromGallery (){
    Future<void> _getFromGallery() async {

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path );
        });

      }
    }

    _getFromGallery();
  }

  final namecontroller =TextEditingController();
  final fathernamecontroller =TextEditingController();
  final dobcontroller =TextEditingController();
  final phone_no_controller =TextEditingController();
  final serialnocontroller=TextEditingController();
  final regnocontroller=TextEditingController();


// final fireStore=FirebaseFirestore.instance.collection('Users');
// CollectionReference ref=FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[300],
        title: Text("Add Student in "+widget.Addinclass),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red,
              Colors.blue,
            ],
          ),
        ),
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
            InkWell(
              onTap: (){
               selectImageSource();
              },
              child: Container(
                child:   imageFile.path!=""?CircleAvatar(
                  radius: 80,
                  backgroundImage:  FileImage(
                    imageFile,
                  ),

                ) :
                CircleAvatar(

                    radius: 80,
                    backgroundColor: Colors.white,
                    child:  Icon(Icons.person_add_alt,
                      color: Colors.red,
                      size: 80,
                    )
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: namecontroller,
                  decoration:InputDecoration(
                    prefixIcon:Icon( Icons.person_outline_outlined),
                    hintText: "Name",
                    border: OutlineInputBorder(
borderRadius: BorderRadius.circular(20,)
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: fathernamecontroller,
                  decoration:InputDecoration(
                    prefixIcon:Icon( Icons.person_outline_outlined),
                    hintText: "Father's Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20,)
                    ),

                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(

                        controller: serialnocontroller,
                        decoration:InputDecoration(
                          prefixIcon:Icon( Icons.numbers),
                          hintText: "Serial No",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20,)
                          ),

                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(

                        controller: regnocontroller,
                        decoration:InputDecoration(
                          prefixIcon:Icon( Icons.numbers),
                          hintText: "Reg no",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20,)
                          ),

                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(

                  controller: phone_no_controller,
                  decoration:InputDecoration(
                    prefixIcon:Icon( Icons.call),
                    hintText: "Phone No",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20,)
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(

                  controller: dobcontroller,
                  decoration:InputDecoration(
                    prefixIcon:Icon( Icons.cake),
                    suffixIcon: InkWell(
                        onTap: (){
                          {
                            DatePicker.showDatePicker(
                              context,

                                onChanged: (date) {
                                String datetime=date.toString();
                                  final splitted = datetime.split(' ');
                                 dobcontroller.text=splitted[0];
                                }, onConfirm: (date) {
                              String datetime=date.toString();
                              final splitted = datetime.split(' ');
                              dobcontroller.text=splitted[0];
                                },
                                );
                          }

                        },
                        child: Icon(Icons.date_range)),
                    hintText: "DOB",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20,)
                    ),

                  ),
                ),
              ),

              SizedBox(height: 10,),
              Roundbutton(title: uploading==false?"Add Student":"Wait! it's uploading", colour: Colors.red.shade300,
                  onTap: () async {
setState(() {
  uploading=true;
});
                    final fireStore=FirebaseFirestore.instance.collection(widget.Addinclass);
                    CollectionReference ref=FirebaseFirestore.instance.collection(widget.Addinclass);
                    String id=DateTime.now().microsecondsSinceEpoch.toString();
                  String datetime=DateTime.now().day.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().year.toString()+"  "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();

                    firebase_storage.Reference storageref =firebase_storage.FirebaseStorage.instance.ref('/'+widget.Addinclass+'/'+id);
                    firebase_storage.UploadTask uploadTask=storageref.putFile(imageFile);
                    await Future.value(uploadTask);
                    var newUrl= await storageref.getDownloadURL();

                    fireStore.doc(id).set({
                      'RegNo':regnocontroller.text.toString(),
                      'serialno':serialnocontroller.text.toString(),
                      'id'    :id,
                      'name' :namecontroller.text.toString(),
                      'fathername' :fathernamecontroller.text.toString(),
                      'phone_no' :phone_no_controller.text.toString(),
                      'time' :datetime,
                      'date_of_birth' :dobcontroller.text.toString(),
                      'imgUrl':newUrl.toString()

                    }).then((value) {
                      setState(() {
                        uploading=false;
                      });
                      Utils().toastmessege("Successfully Added", Colors.red.shade200);
                      setState(() {
                        namecontroller.clear();
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Firestorescreen(classs: widget.Addinclass,)));
                    }).onError((error, stackTrace) {
                      setState(() {
                        uploading=false;
                      });
                      Utils().toastmessege(error.toString(), Colors.red.shade200);
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Firestorescreen(classs: widget.Addinclass)));
                  }),
            ],
          ),
        ),
      ),
    );
  }

}
