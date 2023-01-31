import 'package:flutter/material.dart';

class verify_phone_no extends StatefulWidget {
  final String verify;
  const verify_phone_no({Key? key,required this.verify}) : super(key: key);

  @override
  State<verify_phone_no> createState() => _verify_phone_noState();
}

class _verify_phone_noState extends State<verify_phone_no> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[300],
        title: Text("Verify"),
      ),
      body: Container(

        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
