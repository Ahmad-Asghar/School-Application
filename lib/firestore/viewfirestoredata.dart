import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
class viewfirestoredata extends StatefulWidget {
final String imageUrl;
final String registration_no;
final String serial_no;
      final String name;
      final String fathername;
      final String phonenumber;
      final String dateofbirth;
   viewfirestoredata(
      {Key? key,
        required this.registration_no,
        required this.serial_no,
        required this.imageUrl,
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
          centerTitle: true,
          backgroundColor: Colors.red[300],
          title: Text("Student Data"),
        ),
        body: Container(

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
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              widget.imageUrl==""? CircleAvatar(
                radius: 80,
                child: Icon(Icons.question_mark,

                size: 80,),
              ):CircleAvatar(
                radius: 80,
                backgroundImage: CachedNetworkImageProvider(
                    widget.imageUrl),
              ),
              SizedBox(height: 35),
              Padding(
                padding:  EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Serial No :  "+ widget.serial_no,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.edit))
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding:  EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Registration No :  "+ widget.registration_no,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.edit)),


                  ],
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding:  EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Name :  "+ widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                        child: Icon(Icons.edit))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding:  EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Father's Name :  "+ widget.fathername,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.edit))
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding:  EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Phone no :  "+ widget.phonenumber,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.edit))
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding:  EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text("Date of Birth :  "+ widget.dateofbirth,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.edit)),


                  ],
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
