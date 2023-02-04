import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project_2/firestore/add_firestore_data.dart';
import 'package:firebase_project_2/firestore/usernames.dart';
import 'package:firebase_project_2/firestore/viewfirestoredata.dart';
import 'package:firebase_project_2/utility/utils.dart';
import 'package:firebase_project_2/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Firestorescreen extends StatefulWidget {
  final String classs;
  const Firestorescreen({Key? key, required this.classs,}) : super(key: key);

  @override
  State<Firestorescreen> createState() => _FirestorescreenState();
}

class _FirestorescreenState extends State<Firestorescreen> {
  final editcontroller =TextEditingController();
  final auth=FirebaseAuth.instance;
  //final fireStore=FirebaseFirestore.instance.collection(widget.classs).snapshots();
   // CollectionReference firestore_ref=FirebaseFirestore.instance.collection('Users');




  @override

  Future<void> showdialouge(String title,String id) async{
    editcontroller.text=title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Update"),
            content: Container
              (
              child: TextField(
                controller: editcontroller,
                decoration: InputDecoration(
                    hintText: "Edit"
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancel")),
              TextButton(
                  onPressed: (){
                    FirebaseFirestore.instance.collection(widget.classs).doc(id).update({
'name':editcontroller.text

}).then((value) {
  Utils().toastmessege('Updated', Colors.green.shade200);
          }).onError((error, stackTrace) {

            Utils().toastmessege(error.toString(), Colors.green.shade200);
          });
//
                    Navigator.pop(context);
                  }, child: Text("Update")),
            ],
          );
        }

    );

  }

  Widget build(BuildContext context) {

    return WillPopScope(
     onWillPop: () async{
       Navigator.pop(context);
       return  true;
     },
      child: Scaffold(

        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red[400],
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>add_firestoredata(Addinclass: widget.classs,)));
            },
            child: Icon(Icons.add)
        ),
        appBar: AppBar(

          backgroundColor: Colors.red[300],
          title: Text(widget.classs),
          centerTitle: true,
        ),
        body: Container(
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
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(widget.classs).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
if (snapshot.connectionState==ConnectionState.waiting){
  print('called');


  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: Colors.red[500],
        ),
      ],
  );
}

if(snapshot.hasError){
  return Center(child: Text("Something went wrong!"));
}
              return Expanded(

                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red[100],
                          child: ListTile(
onTap: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>viewfirestoredata(
    name: snapshot.data!.docs[index]['name'].toString(),
    fathername: snapshot.data!.docs[index]['fathername'].toString(),
    dateofbirth: snapshot.data!.docs[index]['date_of_birth'].toString(),
    phonenumber: snapshot.data!.docs[index]['phone_no'].toString(),
    imageUrl: snapshot.data!.docs[index]['imgUrl'].toString(),
    registration_no: snapshot.data!.docs[index]['RegNo'].toString(),
    serial_no:snapshot.data!.docs[index]['serialno'].toString() ,

  )));
}
                            ,
                            leading: snapshot.data!.docs[index]['imgUrl'].toString()==""? CircleAvatar(
                              child: Icon(Icons.question_mark),
                            ):CircleAvatar(
backgroundImage: CachedNetworkImageProvider(
    snapshot.data!.docs[index]['imgUrl'].toString()),
                            ),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: ( context) =>[
                                PopupMenuItem(
                                  value: 1, child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showdialouge(snapshot.data!.docs[index]['name'].toString(),snapshot.data!.docs[index]['id'].toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                ),

                                ),
                                PopupMenuItem(
                                  value: 1, child: ListTile(
                                  onTap: (){
                                   // ref.child(list[index]['id']).remove();

                                    FirebaseFirestore.instance.collection(widget.classs).doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                    print(snapshot.data!.docs[index]['id'].toString());
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete"),
                                ),

                                )
                              ],
                            ),

                            title: Text(snapshot.data!.docs[index]['name'].toString()),
                            subtitle: Text(snapshot.data!.docs[index]['date_of_birth'].toString()),

                          ),
                        ),
                      );
                    }

                ),
              );
              }),
        ),
      ),
    );
  }
}

