import 'package:flutter/material.dart';
import 'package:venue/common/loginpage.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

import '../screens/user/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState(){

    Future.delayed(
      Duration(seconds: 3),
        () =>Navigator.push(
            context, MaterialPageRoute(builder: (context)=>LoginPage())));

    super.initState();
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:backColor,
      body: Container(

        height: double.infinity,
        width: double.infinity,


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Image.asset('assets/images/logo.png',height: 300,width: 300,),
            AppText(text: "Venue",
              size: 40,
              color: Colors.white,
              fw: FontWeight.w900,


            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
