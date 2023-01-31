
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_2/firestore/firestorescreen.dart';
import 'package:firebase_project_2/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../utility/utils.dart';


class add_firestoredata extends StatefulWidget {
  final String Addinclass;
  const add_firestoredata({Key? key,required this.Addinclass}) : super(key: key);

  @override
  State<add_firestoredata> createState() => _add_firestoredataState();
}

class _add_firestoredataState extends State<add_firestoredata> {

  final namecontroller =TextEditingController();
  final fathernamecontroller =TextEditingController();
  final dobcontroller =TextEditingController();
  final phone_no_controller =TextEditingController();

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
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),

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
              Roundbutton(title: "Add Student", colour: Colors.red.shade300,
                  onTap: () {
                    final fireStore=FirebaseFirestore.instance.collection(widget.Addinclass);
                    CollectionReference ref=FirebaseFirestore.instance.collection(widget.Addinclass);
                    String id=DateTime.now().microsecondsSinceEpoch.toString();

                  String datetime=DateTime.now().day.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().year.toString()+"  "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
                    fireStore.doc(id).set({
                      'id'    :id,
                      'name' :namecontroller.text.toString(),
                      'fathername' :fathernamecontroller.text.toString(),
                      'phone_no' :phone_no_controller.text.toString(),
                      'time' :datetime,
                      'date_of_birth' :dobcontroller.text.toString(),

                    }).then((value) {
                      Utils().toastmessege("Successfully Added", Colors.red.shade200);
                      setState(() {
                        namecontroller.clear();

                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Firestorescreen(classs: widget.Addinclass,)));
                    }).onError((error, stackTrace) {
                      Utils().toastmessege(error.toString(), Colors.red.shade200);
                    });


                  }),
            ],
          ),
        ),
      ),
    );
  }

}
