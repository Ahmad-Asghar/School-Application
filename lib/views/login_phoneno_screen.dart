import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_2/views/verify_phone_no.dart';
import 'package:flutter/material.dart';

import '../utility/utils.dart';
import '../widgets/round_button.dart';

class loginwithphone extends StatefulWidget {
  const loginwithphone({Key? key}) : super(key: key);

  @override
  State<loginwithphone> createState() => _loginwithphoneState();
}

class _loginwithphoneState extends State<loginwithphone> {

  FirebaseAuth _auth=FirebaseAuth.instance;
  final _formkey=GlobalKey<FormState>();
  final phonenumbercontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text("Login With Phone"),
        centerTitle: true,
      ),
      body: Container
        (
        height: double.infinity,
        width: double.infinity,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: TextFormField(

                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Phone Number';

                    }
                    else{
                      return null;
                    }
                  },

                  controller: phonenumbercontroller,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
            ),
            Roundbutton(title: 'Login',onTap: () {
              if(_formkey.currentState!.validate()){

                
                _auth.verifyPhoneNumber(
                  phoneNumber: phonenumbercontroller.text,
                    verificationCompleted: (_){},
                    verificationFailed: (e){
                      Utils().toastmessege(e.toString(), Colors.deepPurple.shade300);
                    },
                    codeSent: (String verificationId,int? code){
 Navigator.push(context, MaterialPageRoute(builder: (context)=>verify_phone_no(verify: verificationId,)));

                    },
                    codeAutoRetrievalTimeout:(e){
                      Utils().toastmessege(e.toString(), Colors.deepPurple.shade300);
                    }

                );


              }
            }, colour:Colors.deepPurple.shade400),
          ],
        ),
      ),
    );
  }
}
