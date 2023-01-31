import 'package:flutter/material.dart';
class viewfirestoredata extends StatefulWidget {

      final String name;
      final String fathername;
      final String phonenumber;
      final String dateofbirth;
   viewfirestoredata(
      {Key? key,
        required this.name,
        required this.fathername,
        required this.dateofbirth,
        required this.phonenumber  }) : super(key: key);

  @override
  State<viewfirestoredata> createState() => _viewfirestoredataState();
}

class _viewfirestoredataState extends State<viewfirestoredata> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text("Student Data"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Name :"+ widget.name,
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold
                   ),
                   ),
                   Text("Father's Name :"+widget.fathername,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold
                     ),
                   ),
                   SizedBox(height: 10,),
                   Text("Phone No :"+widget.phonenumber,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold
                     ),
                   ),
                   SizedBox(height: 10,),
                   Text("DOB: "+widget.dateofbirth,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold
                     ),
                   ),

                 ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
