import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String? text;
  double? size;
  Color? color;
  FontWeight?fw;
  TextAlign?talign;
  bool?sw;

   AppText({Key? key,required this.text,this.size=22,this.color,this.fw, this.talign,this.sw=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.left,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.0,
      style: TextStyle(
          fontSize: size,
          fontWeight: fw,
          fontFamily: 'poppins',
          color:color,
      ),
    );
  }
}

