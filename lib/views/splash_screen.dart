import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_2/firestore/usernames.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    final auth= FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>usernames()))
      );
    }
   else{
      Timer(Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()))
      );
    }
  }
  @override

  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
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
          child: Center(
            // child: Expanded(
            //   child: Text("Al Badar Model Girls High School ",
            //   style: TextStyle(
            //
            //     fontWeight: FontWeight.bold,
            //     fontSize: 40
            //   ),
            //   ),
            // ),
            ),
          ),
        ),
      );
  }
}
