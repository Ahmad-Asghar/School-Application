import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_2/posts/posts.dart';
import 'package:firebase_project_2/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utility/utils.dart';

class add_posts extends StatefulWidget {
  const add_posts({Key? key}) : super(key: key);

  @override
  State<add_posts> createState() => _add_postsState();
}

class _add_postsState extends State<add_posts> {

  final postcontroller =TextEditingController();

  final firebaseRef =FirebaseDatabase.instance.ref("posts");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[300],
        title: Text("Add Posts"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child:Column(
          children: [
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: postcontroller,
                maxLines: 5,
                decoration:InputDecoration(
                  hintText: "What's in your mind?",
                  border: OutlineInputBorder(

                  ),

                ),
              ),
            ),

            SizedBox(height: 10,),
            Roundbutton(title: "Add post", colour: Colors.brown.shade400, onTap: (){
              String id=DateTime.now().microsecondsSinceEpoch.toString();
              firebaseRef.child(id).set({
                'id':id,
                'post_title': postcontroller.text.toString()

              }).then((value) {
                Utils().toastmessege("Post Added Successfully", Colors.brown.shade300);
              }).onError((error, stackTrace) {
                Utils().toastmessege(error.toString(), Colors.brown.shade300);
              });
              Navigator.push(context, MaterialPageRoute(builder: (context)=>post_screen()));
            }),
          ],
        ),
      ),
    );
  }
}
