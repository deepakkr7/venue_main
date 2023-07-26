import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venue/admin/adminhome.dart';
import 'package:venue/common/resgister.dart';
import 'package:venue/screens/auditorium/audhomepage.dart';
import 'package:venue/screens/eventmanagers/eventhomepage.dart';
import 'package:venue/screens/user/bottomnavigationpage.dart';
import 'package:venue/screens/user/homepage.dart';
import 'package:venue/utilities/apptext.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPass = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 30, top: 30),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HeaderWidget(),
                        //Text("Venue",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        //Text("Login to your Account",style: TextStyle(fontSize: 10,),

                        AppText(
                            text: "Login to your Account",
                            size: 24,
                            color: Colors.white),

                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Enter a valid email";
                            }
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: btnColor, width: 2)),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black54)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.length <= 5) {
                              return "Password should be of minimum 5 characters";
                            }
                          },
                          controller: passwordController,
                          obscureText: showPass,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: btnColor, width: 2)),
                            hintText: "Password ",
                            hintStyle: TextStyle(color: Colors.black54),
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (showPass == true) {
                                  setState(() {
                                    showPass = false;
                                  });
                                } else {
                                  setState(() {
                                    showPass = true;
                                  });
                                }
                              },
                              icon: showPass == true
                                  ? Icon(Icons.visibility_off,
                                      color: btnColor.withOpacity(0.5))
                                  : Icon(
                                      Icons.visibility,
                                      color: btnColor,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (usernameController.text ==
                                      "admin@gmail.com" &&
                                  passwordController.text == "123456789") {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminHomePage()),
                                    (route) => false);
                              } else {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: usernameController.text,
                                        password: passwordController.text)
                                    .then((user) => FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(user.user!.uid)
                                            .get()
                                            .then((value) {
                                          if (value.data()!['usertype'] ==
                                              'user') {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavigationPage(
                                                          img: value
                                                              .data()!['img'],
                                                          fname: value
                                                              .data()!['fname'],
                                                          lname: value
                                                              .data()!['lname'],
                                                          pin: value
                                                              .data()!['pin'],
                                                          place: value
                                                              .data()!['place'],
                                                          id: value
                                                              .data()!['id'],
                                                          email: value
                                                              .data()!['email'],
                                                          phone: value
                                                              .data()!['phone'],
                                                        )),
                                                (route) => false);
                                          }

                                          else if (value.data()!['usertype'] ==
                                              'auditorium' && value.data()!['status'] ==1) {
                                            print(value.data()!['email']);
                                            print(value.data()!['audname']);
                                            print(value.data()!['phoneno']);
                                            print(value.data()!['place']);
                                            print(value.data()!['pin']);
                                            print(value.data()!['id']);

                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AudHomePage(
                                                          email: value
                                                              .data()!['email'],
                                                          audname:
                                                              value.data()![
                                                                  'audname'],
                                                          phoneno:
                                                              value.data()![
                                                                  'phoneno'],
                                                          place: value
                                                              .data()!['place'],
                                                          pin: value
                                                              .data()!['pin'],
                                                          id: value
                                                              .data()!['id'],
                                                          imgurl: value
                                                              .data()!['img'],
                                                          facility:
                                                              value.data()![
                                                                  'facilities'],
                                                        )),
                                                (route) => false);
                                          }

                                          else if(value.data()!['usertype'] ==
                                              'event' && value.data()!['status'] ==
                                             1) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventHomePage(
                                                          email: value
                                                              .data()!['email'],
                                                          eventname:
                                                              value.data()![
                                                                  'eventname'],
                                                          phoneno:
                                                              value.data()![
                                                                  'phoneno'],
                                                          place: value
                                                              .data()!['place'],
                                                          pin: value
                                                              .data()!['pin'],
                                                          id: value
                                                              .data()!['id'],
                                                        )),
                                                (route) => false);
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Waiting for Admin Approval")));
                                          }
                                        }).catchError((e) {
                                          var err = e.toString().split("]");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(err[1].toString())));
                                        }))
                                    .catchError((e) {
                                  var list = e.toString().split("]");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: btnColor,
                                          content: Container(
                                              height: 100,
                                              child: Center(
                                                  child: Text("${list[1]}")))));
                                });
                              }

                              print(usernameController.text);
                              print(passwordController.text);
                            }
                          },
                          child: Container(
                            height: 45,
                            width: 200, 
                            decoration: BoxDecoration(
                              color: btnColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: AppText(
                                text: "Login",
                                size: 20,
                                color: Colors.black,
                                fw: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 100),
                            AppText(
                              text: "Don't have an account?",
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationPage()));
                                },
                                child: AppText(
                                  text: "Register",
                                  size: 20,
                                  fw: FontWeight.w700,
                                  color: btnColor,
                                )),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
