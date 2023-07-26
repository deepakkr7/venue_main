import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:venue/admin/adminhome.dart';
import 'package:venue/common/loginpage.dart';
import 'package:venue/screens/auditorium/audhomepage.dart';
import 'package:venue/screens/eventmanagers/eventhomepage.dart';
import 'package:venue/screens/user/userregistration.dart';

import 'common/splashpage.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      routes: {
        '/login':(context) => LoginPage(),
      },

      home:SplashPage()
    );
  }
}


