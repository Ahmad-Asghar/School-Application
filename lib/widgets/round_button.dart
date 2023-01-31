import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
  final Color colour;
  final String title;
  final VoidCallback onTap;
 final  bool loading;
  const Roundbutton(
       {Key? key,
    required this.title, required this.onTap, required this.colour,
this.loading=false,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return InkWell(
onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
height: 55,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colour,
                ),
child:loading?
Padding(
  padding:  EdgeInsets.only(left: 150,right: 150,top: 7,bottom: 7),
  child:   CircularProgressIndicator(
   color: Colors.white,
  ),
) :Align(
    alignment: Alignment.center,
    child: Text(title)),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
