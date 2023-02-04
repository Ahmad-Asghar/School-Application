import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_2/firestore/firestorescreen.dart';
import 'package:firebase_project_2/firestore/viewfirestoredata.dart';
import 'package:flutter/material.dart';

import '../utility/utils.dart';
import '../views/login_screen.dart';
class usernames extends StatefulWidget {
  const usernames({Key? key}) : super(key: key);

  @override
  State<usernames> createState() => _usernamesState();
}

class _usernamesState extends State<usernames> {
  @override

TextEditingController editcontroller=TextEditingController();
  final auth=FirebaseAuth.instance;
  final fireStore1=FirebaseFirestore.instance.collection('Names of Classes').snapshots();
  final fireStore=FirebaseFirestore.instance.collection('Names of Classes');
  CollectionReference firestore_ref=FirebaseFirestore.instance.collection('Names of Classes');
   Future<void> showdialouge() async{
     editcontroller.text='Class ';
    return showDialog(

        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Add New Class"),
            content: Container
              (
              child: TextField(
                controller: editcontroller,
                decoration: InputDecoration(

                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancel")),
              TextButton(
                  onPressed:(){
                   setState(() {
                     String id=DateTime.now().microsecondsSinceEpoch.toString();

                     String datetime=DateTime.now().day.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().year.toString()+" ,"+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
                     fireStore.doc(id).set({
                       'id'    :id,
                       'title' :editcontroller.text.toString(),
                       'time' :datetime,



                     }).then((value) {
                       Utils().toastmessege("Successfully Added", Colors.red.shade200);
                       setState(() {
                         editcontroller.clear();

                       });

                     }).onError((error, stackTrace) {
                       Utils().toastmessege(error.toString(), Colors.red.shade200);
                     });
                   });
                    Navigator.pop(context);
                  },child: Text("Add")),
            ],
          );
        }

    );

  }


  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],

        child: Icon(Icons.add),
        onPressed: (){
          showdialouge();
        },

      ),
      appBar: AppBar(

        actions: [
          IconButton(onPressed: (){

            auth.signOut().then((value) {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
            }).onError((error, stackTrace) {
              Utils().toastmessege(error.toString(), Colors.red[300]!);
            });
          },
            icon: Icon( Icons.logout),)
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red[200],
        title: Text("Classes"),
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
            stream: fireStore1,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Firestorescreen(classs: snapshot.data!.docs[index]['title'].toString())));
                            }
                            ,
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: ( context) =>[
                                // PopupMenuItem(
                                //
                                //   value: 1, child: ListTile(
                                //   onTap: (){
                                //     Navigator.pop(context);
                                //    // showdialouge(snapshot.data!.docs[index]['title'].toString(),snapshot.data!.docs[index]['id'].toString());
                                //   },
                                //   leading: Icon(Icons.edit),
                                //   title: Text("Edit"),
                                // ),
                                //
                                // ),
                                PopupMenuItem(
                                  value: 1, child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    //ref.child(list[index]['id']).remove();
                                     firestore_ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete"),
                                ),

                                )
                              ],
                            ),

                            title: Text(snapshot.data!.docs[index]['title'].toString()),

                          ),
                        ),
                      );
                    }

                ),
              );
            }),
      ),
    );
  }
}
