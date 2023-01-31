import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project_2/posts/add_posts.dart';
import 'package:firebase_project_2/utility/utils.dart';
import 'package:firebase_project_2/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class post_screen extends StatefulWidget {
  const post_screen({Key? key}) : super(key: key);

  @override
  State<post_screen> createState() => _post_screenState();
}

class _post_screenState extends State<post_screen> {

  final editcontroller =TextEditingController();
  final auth=FirebaseAuth.instance;
  final ref =FirebaseDatabase.instance.ref('posts');

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
                    ref.child(id).update(
                      {
                        'post_title':editcontroller.text.toString(),
                      }
                    ).then((value)  {

                    }).onError((error, stackTrace)  {
                      Utils().toastmessege(error.toString(), Colors.red.shade300);
                    });
                Navigator.pop(context);
              }, child: Text("Update")),
            ],
          );
        }

    );

  }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_posts()));
        },
        child: Icon(Icons.add)
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
        backgroundColor: Colors.red[300],
        title: Text("Posts"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(

                stream: ref.onValue,
                builder: (context,AsyncSnapshot<DatabaseEvent>snapshot) {

                  if(!snapshot.hasData){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 300),
                      child: CircularProgressIndicator(),
                    );
                  }
                 else {

                   Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;

                   List <dynamic> list=[];
                   list.clear();
                   list=map.values.toList();
                    return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context,index){

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red[100],
                          child: ListTile(

                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: ( context) =>[
                                PopupMenuItem(

                                  value: 1, child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    showdialouge(list[index]['post_title'],list[index]['id']);
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                ),
                                  
                                ),
                                PopupMenuItem(
                                  value: 1, child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
ref.child(list[index]['id']).remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete"),
                                ),

                                )
                              ],
                            ),
title: Row(
  children: [
    Text((index+1).toString()),
        SizedBox(width: 6,),
        Text(list[index]['post_title']),
  ],
),

                          ),
                        ),
                      );
                    });
                  }

                }
              ),
            )
            // Expanded(child: FirebaseAnimatedList(query: ref, itemBuilder: (context,snapshot,animation,index){
            //
            //   return ListTile(
            //
            //     title: Text(snapshot.child('post_title').value.toString()),
            //   );
            // }))
          ],
        ),
      ),
    );
  }
}
