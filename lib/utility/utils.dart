import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  void toastmessege(String messege,Color culur){
    Fluttertoast.showToast(
        msg: messege,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: culur,
        textColor: Colors.black,
        fontSize: 12.0
    );
  }
}