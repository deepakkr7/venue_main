import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/addfeedbacks.dart';
import 'package:venue/screens/user/callbackrequest.dart';
import 'package:venue/screens/user/commonfeedbackadmin.dart';
import 'package:venue/screens/user/homepage.dart';
import 'package:venue/screens/user/vieprofile_.dart';
import 'package:venue/screens/user/viewallnotification%20(1).dart';
import 'package:venue/screens/user/viewallordersusers.dart';
import 'package:venue/screens/user/viewprofile.dart';
import 'package:venue/utilities/apptext.dart';

class BottomNavigationPage extends StatefulWidget {
  var email;
  var fname;
  var lname;
  var pin;
  var place;
  var id;
  var phone;
  String? img;
  BottomNavigationPage(
      {Key? key,
      this.phone,
      this.email,
      this.fname,
      this.lname,
      this.pin,
      this.place,
      this.id,
      this.img})
      : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedindex = 0;
  var email;
  var fname;
  var lname;
  var pin;
  var place;
  var id;
  var phone;
  var img;

  var imgurl;
  getdata() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    imgurl = _pref.getString('img');

    setState((){


    });
  }

  SetData() {
    email = widget.email;
    fname = widget.fname;
    lname = widget.lname;
    pin = widget.pin;
    place = widget.place;
    id = widget.id;
    phone = widget.phone;
    img = widget.img;
  }

  List<Widget> _widgetOptions = [];
  @override
  initState() {
    getdata();
    SetData();
    _widgetOptions = [
      HomePage(
        email: email,
        fname: fname,
        lname: lname,
        pin: pin,
        place: place,
        id: id,
        phone: phone,
        imgurl_pref: img,
      ),
      ViewAllOrdersUser(
        email: email,
        fname: fname,
        lname: lname,
        pin: pin,
        place: place,
        id: id,
        phone: phone,
        imgurl_pref: img,
      ),
      ViewProfile_bottom(
        email: email,
        fname: fname,
        lname: lname,
        pin: pin,
        place: place,
        uid: id,
        phone: phone,
        imgurl: img,
      ),
    ViewAllNotificationsUSer(
      uid: id,
    )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: backColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfile(
                                        uid: widget.id,
                                        fname: widget.fname,
                                        lname: widget.lname,
                                        place: widget.place,
                                        pin: widget.pin,
                                        phone: widget.phone,
                                      )));
                        },
                        child: img != null
                            ? Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: btnColor,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                        image:
                                            NetworkImage(img.toString()))),
                              )
                            : Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: btnColor,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/userdefault.png'))),
                              ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(widget.fname, style: TextStyle(color: Colors.white))
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewCAllbackRequest(
                              id: widget.id,
                            )));
              },
              title: AppText(
                text: "View Requests",
                size: 18,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFeedBack(
                              id: widget.id,
                              phone: widget.phone,
                              name: widget.fname,
                            )));
              },
              title: AppText(
                text: "Add Feedback",
                size: 18,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAllCommonFeedbackUser(
                              id: widget.id,
                            )));
              },
              title: AppText(
                text: "Feedback History",
                size: 18,
              ),
            )
          ],
        ),
      ),
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: btnColor,
        actions: [



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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: btnColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: backColor,
        currentIndex: _selectedindex,
        onTap: (int index) {
          setState(() {
            _selectedindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: btnColor,
              label: "Home",
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              backgroundColor: btnColor,
              label: "Orders",
              icon: Icon(Icons.history)),
          BottomNavigationBarItem(
              backgroundColor: btnColor,
              label: "Profile",
              icon: Icon(Icons.person)),
          BottomNavigationBarItem(
              backgroundColor: btnColor,
              label: "Messages",
              icon: Icon(Icons.notifications))
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _widgetOptions.elementAt(_selectedindex)),
    );
  }
}
