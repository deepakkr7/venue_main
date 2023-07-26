import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venue/common/loginpage.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/auditorium/addpackages.dart';
import 'package:venue/screens/auditorium/audbookings.dart';
import 'package:venue/screens/auditorium/audfeedbacks.dart';
import 'package:venue/screens/auditorium/audpayments.dart';
import 'package:venue/screens/auditorium/audprofile.dart';
import 'package:venue/screens/auditorium/audservices.dart';
import 'package:venue/screens/auditorium/viewallanotification_aud.dart';
import 'package:venue/screens/user/detailscreen.dart';
import 'package:venue/utilities/apptext.dart';
import 'package:venue/utilities/header.dart';

class AudHomePage extends StatefulWidget {
  var email;
  var audname;
  var phoneno;
  var pin;
  var place;
  var id;
  var imgurl;
  var facility;

  AudHomePage(
      {Key? key,
      this.email,
      this.facility,
      this.audname,
      this.phoneno,
      this.place,
      this.imgurl,
      this.pin,
      this.id})
      : super(key: key);

  @override
  State<AudHomePage> createState() => _AudHomePageState();
}

class _AudHomePageState extends State<AudHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.audname);
    print(widget.id);
    print(widget.place);

    return Scaffold(
        //backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: btnColor,
          actions: [
            IconButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotificationsAud()));

            }, icon: Icon(Icons.notifications)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Sign Out"),
                          content: Container(
                            child: Text("Do You Really want to  log out"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut().then(
                                      (value) =>
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              "/login",
                                              (Route<dynamic> route) => false));
                                },
                                child: Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No"))
                          ],
                        );
                      });
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  AppText(
                    text: "Welcome ${widget.audname}",
                    size: 28,
                    fw: FontWeight.w800,
                    color: backColor,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  AppText(
                    text: "Auditorium Dashboard",
                    size: 26,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewAllAudBooking(
                                            id: widget.id,
                                          )));
                            },
                            child: Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: AppText(
                                text: "View All Bookings",
                                color: Colors.white,
                                size: 18,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddPackages(id: widget.id)));
                            },
                            child: Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: AppText(
                                text: "Manage Services\n & Packages",
                                color: Colors.white,
                                size: 18,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>RatingsViewAud()));
                            },
                            child: Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: AppText(
                                text: "View All\nFeedbacks",
                                color: Colors.white,
                                size: 18,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AudPayments(audid:widget.id)));
                            },
                            child: Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: AppText(
                                text: "View All\nPayments",
                                color: Colors.white,
                                size: 18,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AudProfile(
                                            facilities: widget.facility,
                                            id: widget.id,
                                            email: widget.email,
                                            audname: widget.audname,
                                            place: widget.place,
                                            pin: widget.pin,
                                            phoneno: widget.phoneno,
                                            imgurl: widget.imgurl,
                                          )));
                            },
                            child: Container(
                              height: 100,
                              width: 300,
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: AppText(
                                text: "Edit/Update Profile",
                                color: Colors.white,
                                size: 18,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}
