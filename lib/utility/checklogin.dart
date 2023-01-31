import 'package:firebase_auth/firebase_auth.dart';

class checkLogin{

  void checkuserlogin(){
    final auth= FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){

    }

  }
}