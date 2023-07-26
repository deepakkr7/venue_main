import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venue/admin/AllEventManagers.dart';
import 'package:venue/admin/manageauditoriums.dart';
import 'package:venue/admin/managenotifications.dart';
import 'package:venue/admin/manageservices.dart';
import 'package:venue/admin/viewallauditorium.dart';
import 'package:venue/admin/viewallfeedbacks.dart';
import 'package:venue/admin/viewallpayments.dart';
import 'package:venue/admin/viewallusers.dart';
import 'package:venue/common/loginpage.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/eventmanagers/eventbookings.dart';
import 'package:venue/screens/eventmanagers/eventfeedbacks.dart';
import 'package:venue/screens/eventmanagers/eventpayments.dart';
import 'package:venue/screens/eventmanagers/eventprofile.dart';
import 'package:venue/screens/eventmanagers/eventservices.dart';
import 'package:venue/screens/eventmanagers/ratings.dart';
import 'package:venue/screens/eventmanagers/viewallnotificationevent.dart';
import 'package:venue/utilities/apptext.dart';

class EventHomePage extends StatefulWidget {

  var email;
  var eventname;
  var phoneno;
  var pin;
  var place;
  var id;

   EventHomePage({Key? key,this.email,this.eventname,this.phoneno,this.place,this.pin,this.id}) : super(key: key);

  @override
  State<EventHomePage> createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        actions: [
          IconButton(onPressed: (){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotificationsEvent()));

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
                                FirebaseAuth.instance.signOut().then((value) =>
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
              text: "Welcome ${widget.eventname}",
              size: 28,
              fw: FontWeight.w800,
              color: backColor,
            ),
            SizedBox(height: 20,),

            AppText(
              text: "Event Managers Dashboard",
              size: 26,
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
                                builder: (context) => ViewAllEventBooking(
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
                                builder: (context) => EventServices(
                                  id: widget.id,
                                  email: widget.email,
                                  place: widget.place,
                                  phoneno: widget.phoneno,
                                  pin: widget.pin,
                                  eventname: widget.eventname,

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
                          text: "Manage Services",
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
                                builder: (context) =>EventProfile(
                                  id: widget.id,
                                  eventname: widget.eventname,
                                  email: widget.email,
                                  place: widget.place,
                                  phoneno: widget.phoneno,
                                  pin: widget.pin,
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
                          text: "Edit Profile",
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
                                builder: (context) => RatingsView(id: widget.id,)));
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
                          text: "View All Ratings",
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
          ],
        ),
      ),
    );
  }
}
