import 'package:flutter/material.dart';
import 'package:venue/utilities/header.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  @override
  Widget build(BuildContext context) {
    return Container(

      height: double.infinity,

      child: SingleChildScrollView(
        child: Column(


          children: [

            HeaderWidget()


          ],
        ),
      ),
    );
  }
}
