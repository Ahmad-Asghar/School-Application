import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_2/views/login_screen.dart';
import 'package:firebase_project_2/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../utility/utils.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
bool loading=false;
  final _formkey=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final passwordcontroller =TextEditingController();

  FirebaseAuth _auth=FirebaseAuth.instance;
  @override

  void dispose(){
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void signUp(){
    setState(() {
      loading=true;
    });
    if(_formkey.currentState!.validate()){

      _auth.createUserWithEmailAndPassword(
          email:emailcontroller.text.toString(),
          password: passwordcontroller.text.toString()).then((value)
      {
        Utils().toastmessege("Successfully Loged In",Colors.green[300]!);
        setState(() {
          loading=false;
        });

      }).onError((error, stackTrace) {
        setState(() {
          loading=false;
        });

        Utils().toastmessege(error.toString(),Colors.green[300]!);

      });
      // emailcontroller.clear();
      // passwordcontroller.clear();

    }
  }
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.green[300],
        centerTitle: true,
        title: Text("Sign up",
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Email';

                          }
                          else{
                            return null;
                          }
                        },
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Password';

                          }
                          else{
                            return null;
                          }
                        },
                        obscureText: true,
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_open),
                        ),
                      ),
                    ),
                  ],
                )),

            Roundbutton(loading:loading,title: 'Sign Up', colour:Colors.green.shade400,onTap: () {
             signUp();
            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already  have an account?"),
                TextButton(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
                }, child: Text("Login In",
                  style: TextStyle(
                      color: Colors.green[400]
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
