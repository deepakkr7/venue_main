import 'package:flutter/material.dart';

import 'package:venue/constants/colors.dart';
import 'package:venue/screens/auditorium/auditoriumregistration.dart';
import 'package:venue/screens/eventmanagers/eventregistration.dart';
import 'package:venue/screens/user/userregistration.dart';
import 'package:venue/utilities/apptext.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: btnColor,

            tabs: [
              Tab(icon: AppText(text: "User",color: Colors.white,fw: FontWeight.bold, size: 16)),
              Tab(icon: AppText(text:"Auditorium", color: Colors.white,fw: FontWeight.bold,size: 16)),
              Tab(icon: AppText(text:"Event Manager",color: Colors.white,fw: FontWeight.bold,size: 16)),

            ],
          ),

        ),
        body: Container(

          height: double.infinity,
          width: double.infinity,

          child:TabBarView(
            children: [
           UserRegistration(),
              AuditoriumRegistration(),
              EventRegistration()
            ],
          ),
        ),
        ),
      );
  }
}
