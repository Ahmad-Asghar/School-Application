import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_2/views/login_phoneno_screen.dart';
import 'package:firebase_project_2/views/signup_screen.dart';
import 'package:firebase_project_2/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../firestore/usernames.dart';
import '../utility/utils.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
final _formkey=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final passwordcontroller =TextEditingController();
  @override


  void  login(){
    _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordcontroller.text.toString()).then((value)
    {
      Utils().toastmessege("Successfully Loged In",Colors.orange[300]!);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>usernames()));
    }).onError((error, stackTrace) {

Utils().toastmessege(error.toString(),Colors.orange[300]!);

    });

  }
  void dispose(){
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[300],
        centerTitle: true,
        title: Text("Login",
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

            Roundbutton(title: 'Login',onTap: () {
if(_formkey.currentState!.validate()){

login();

}
            }, colour:Colors.orange.shade400,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account!"),
                TextButton(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>signup_screen()));
                }, child: Text("Sign Up",
                style: TextStyle(
                  color: Colors.orange[400]
                ),
                ))
              ],
            ),

            SizedBox(height: 10,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>loginwithphone()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55,

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange.shade400,width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color:Colors.white,
                        ),

                        child: Align(
                            alignment: Alignment.center,
                            child: Text("Login with Phone number"))



                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
