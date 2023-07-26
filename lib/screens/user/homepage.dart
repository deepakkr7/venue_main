import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue/common/loginpage.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/detailscreen.dart';
import 'package:venue/screens/user/eventservicedetails.dart';
import 'package:venue/screens/user/searchpage.dart';
import 'package:venue/screens/user/viewalleventservices_page.dart';
import 'package:venue/utilities/apptext.dart';
import 'package:venue/utilities/header.dart';

class HomePage extends StatefulWidget {
  var email;
  var fname;
  var lname;
  var pin;
  var place;
  var id;
  var phone;
  String?imgurl_pref;

  HomePage(
      {Key? key,
      this.email,
        this.phone,
      this.fname,
      this.lname,
      this.pin,
        this.imgurl_pref,
      this.place,
      this.id})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
var imgurl;
  getdata() async{

    SharedPreferences _pref=await SharedPreferences.getInstance();
   setState((){
     imgurl=_pref.getString('img');
   });
    print(imgurl);
  }

@override
  iniState(){
  imgurl=widget.imgurl_pref;
  print(widget.imgurl_pref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Welcome ${widget.fname}",
                          size: 28,
                          fw: FontWeight.w900,
                          color: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: widget.imgurl_pref==null?Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage('assets/images/userdefault.png')),
                                  color: Colors.red,
                                  shape: BoxShape.circle),
                            ):Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                      NetworkImage(widget.imgurl_pref.toString())),
                                  color: Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: (){
                        
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                      },
                      child: Container(
                        height: 45,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 2,
                                child: AppText(
                                  text:
                                      "  Search Spaces, Event Planners, Photographers",
                                  size: 14,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(Icons.search),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                      text: "Trending Spaces Near You",
                      size: 24,
                      fw: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                        height: 280,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('user')
                              .where('usertype', isEqualTo: 'auditorium')
                              .where('status', isEqualTo: 1)
                              .snapshots(),
                          builder: (context, snapshot) {





                            if(snapshot.hasData && snapshot.data!.docs.length==0){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                         if(snapshot.hasData){

                           return ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: snapshot.data!.docs.length,
                               itemBuilder: (context, index) {
                                 return Padding(
                                   padding: const EdgeInsets.only(right: 8),
                                   child: InkWell(
                                     onTap: () {
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) =>
                                                   DetailsPage(
                                                     id:snapshot.data!
                                                         .docs[index]['id'],
                                                     customerid: widget.id,
                                                     customerPhone: widget.phone,
                                                     cutomername: widget.fname,
                                                     img: snapshot.data!
                                                         .docs[index]['img'],
                                                     name: snapshot
                                                         .data!.docs[index]
                                                     ['audname'],
                                                     phone: snapshot
                                                         .data!.docs[index]
                                                     ['phoneno'],
                                                     email: snapshot.data!
                                                         .docs[index]['email'],
                                                     facility: snapshot
                                                         .data!.docs[index]
                                                     ['facilities'],
                                                   )));
                                     },
                                     child: Card(
                                       elevation: 5.0,
                                       child: Stack(
                                         children: [
                                           Container(
                                             height: 270,
                                             width: 250,
                                             color: Colors.white,
                                             child: Column(
                                               crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                               children: [
                                                 Container(
                                                   height: 200,
                                                   width: 250,

                                                   // color: Colors.green,
                                                   child: snapshot.data!
                                                       .docs[index]
                                                   ['img'] ==
                                                       null
                                                       ? Image.asset(
                                                     'assets/images/img2.jpg',
                                                     fit: BoxFit.cover,
                                                   )
                                                       : Image.network(
                                                       snapshot.data!
                                                           .docs[index]
                                                       ['img'],
                                                       fit: BoxFit.cover),
                                                 ),
                                                 Container(
                                                   height: 70,
                                                   width: size.width,

                                                   //color: Colors.green,

                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment
                                                         .spaceBetween,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment
                                                         .center,
                                                     children: [
                                                       Container(

                                                         padding:
                                                         EdgeInsets.only(
                                                             left: 10),

                                                         width: 250,
                                                         child: Column(
                                                           mainAxisAlignment:
                                                           MainAxisAlignment
                                                               .center,
                                                           crossAxisAlignment:
                                                           CrossAxisAlignment
                                                               .start,
                                                           children: [
                                                             AppText(
                                                               text: snapshot
                                                                   .data!
                                                                   .docs[index]
                                                               ['audname'],
                                                               size: 20,
                                                             ),
                                                             AppText(
                                                               text: snapshot
                                                                   .data!
                                                                   .docs[index]
                                                               ['place'],
                                                               size: 16,
                                                             )
                                                           ],
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                           Positioned(
                                             top: 10,
                                             right: 10,
                                             child: Container(
                                               height: 40,
                                               width: 100,
                                               decoration: BoxDecoration(
                                                   color: Colors.yellow,
                                                   borderRadius:
                                                   BorderRadius.circular(
                                                       12)),
                                               child: Center(
                                                   child: AppText(
                                                     text: "Book Now",
                                                     size: 16, fw: FontWeight.w500,
                                                     color: Colors.black,
                                                   )),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 );
                               });
                         }

                         return Center(
                           child: CircularProgressIndicator(),
                         );
                          },
                        )),
//Photographers
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Never Miss \nBeautiful Moments",
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight:FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Photographers",
                          style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
                        ),
                        InkWell(

                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllEventServiceUSer(
                              title: "Photography",
                            )));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: 280,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('eventservice')
                              .where('title', isEqualTo: 'Photography')
                              .snapshots(),
                          builder: (context, snapshot) {




                            if(snapshot.hasData && snapshot.data!.docs.length==0){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }


                          if(snapshot.hasData){
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ServiceDetailsScreenUser(

                                                      eventname: snapshot.data!.docs[index]['eventname'],
                                                      id: snapshot.data!.docs[index]['id'],
                                                      title: snapshot.data!.docs[index]['title'],
                                                      description: snapshot.data!.docs[index]['description'],
                                                      phone: snapshot.data!.docs[index]['phone'],
                                                      pin: snapshot.data!.docs[index]['pin'],
                                                      location: snapshot.data!.docs[index]['place'],
                                                      customerid: widget.id,
                                                      customerPhone: widget.phone,
                                                      cutomername: widget.fname,
                                                      eventmanagerid: snapshot.data!.docs[index]['eventmanagerid'],
                                                      imgurl: snapshot.data!.docs[index]['imgurl'],

                                                    )));
                                      },
                                      child: Card(
                                        elevation: 5.0,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 270,
                                              width: 250,
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 200,
                                                    width: 250,

                                                    // color: Colors.green,
                                                    child: snapshot.data!
                                                        .docs[index]
                                                    ['imgurl'] ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/photography4.jpg)',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.network(
                                                        snapshot.data!
                                                            .docs[index]
                                                        ['imgurl'],
                                                        fit: BoxFit.cover),
                                                  ),
                                                  Container(
                                                    height: 70,
                                                    width: size.width,

                                                    //color: Colors.green,

                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(
                                                              left: 10),
                                                          //color:Colors.blueGrey,
                                                          width: 150,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              AppText(
                                                                text: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['eventname'],
                                                                size: 20,
                                                              ),
                                                              AppText(
                                                                text: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['place'],
                                                                size: 16,
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12)),
                                                child: Center(
                                                    child: AppText(
                                                      text: "Book Now",
                                                      size: 16,fw: FontWeight.w500,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }


                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
//Event Managers
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Service at its Best",
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Catering Managers",
                          style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
                        ),
                        InkWell(

                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllEventServiceUSer(title: "Catering Service",)));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: 280,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('eventservice')
                              .where('title', isEqualTo: 'Catering Service')
                              .snapshots(),
                          builder: (context, snapshot) {




                         if(snapshot.hasData){

                           return ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: snapshot.data!.docs.length,
                               itemBuilder: (context, index) {
                                 return Padding(
                                   padding: const EdgeInsets.only(right: 8),
                                   child: InkWell(
                                     onTap: () {
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) =>
                                                   ServiceDetailsScreenUser(
                                                     imgurl:  snapshot.data!.docs[index]['imgurl'],
                                                     eventname: snapshot.data!.docs[index]['eventname'],
                                                     id: snapshot.data!.docs[index]['id'],
                                                     title: snapshot.data!.docs[index]['title'],
                                                     description: snapshot.data!.docs[index]['description'],
                                                     phone: snapshot.data!.docs[index]['phone'],
                                                     pin: snapshot.data!.docs[index]['pin'],
                                                     location: snapshot.data!.docs[index]['place'],
                                                     customerid: widget.id,
                                                     customerPhone: widget.phone,
                                                     cutomername: widget.fname,
                                                     eventmanagerid: snapshot.data!.docs[index]['eventmanagerid'],

                                                   )));
                                     },
                                     child: Card(
                                       elevation: 5.0,
                                       child: Stack(
                                         children: [
                                           Container(
                                             height: 270,
                                             width: 250,
                                             color: Colors.white,
                                             child: Column(
                                               crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                               children: [
                                                 Container(
                                                   height: 200,
                                                   width: 250,

                                                   // color: Colors.green,
                                                   child: snapshot.data!
                                                       .docs[index]
                                                   ['imgurl'] ==
                                                       null
                                                       ? Image.asset(
                                                     'assets/images/catering4.jpg)',
                                                     fit: BoxFit.cover,
                                                   )
                                                       : Image.network(
                                                       snapshot.data!
                                                           .docs[index]
                                                       ['imgurl'],
                                                       fit: BoxFit.cover),
                                                 ),
                                                 Container(
                                                   height: 70,
                                                   width: size.width,

                                                   //color: Colors.green,

                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment
                                                         .spaceBetween,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment
                                                         .center,
                                                     children: [
                                                       Container(
                                                         padding:
                                                         EdgeInsets.only(
                                                             left: 10),
                                                         //color:Colors.blueGrey,
                                                         width: 150,
                                                         child: Column(
                                                           mainAxisAlignment:
                                                           MainAxisAlignment
                                                               .center,
                                                           crossAxisAlignment:
                                                           CrossAxisAlignment
                                                               .start,
                                                           children: [
                                                             AppText(
                                                               text: snapshot
                                                                   .data!
                                                                   .docs[index]
                                                               ['eventname'],
                                                               size: 19,
                                                             ),
                                                             AppText(
                                                               text: snapshot
                                                                   .data!
                                                                   .docs[index]
                                                               ['place'],
                                                               size: 15,
                                                             )
                                                           ],
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                           Positioned(
                                             top: 10,
                                             right: 10,
                                             child: Container(
                                               height: 40,
                                               width: 100,
                                               decoration: BoxDecoration(
                                                   color: Colors.yellow,
                                                   borderRadius:
                                                   BorderRadius.circular(
                                                       12)),
                                               child: Center(
                                                   child: AppText(
                                                     text: "Book Now",
                                                     size: 16,fw: FontWeight.w500,
                                                     color: Colors.black,
                                                   )),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 );
                               });
                         }

                         if(snapshot.hasData && snapshot.data!.docs.length==0){
                           return Center(
                             child: CircularProgressIndicator(),
                           );
                         }

                         return Center(
                           child: CircularProgressIndicator(),
                         );
                          }),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Well Planned is half Done",
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Event Managers",
                          style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
                        ),
                        InkWell(

                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllEventServiceUSer(
title: "Event Decoration",
                            )));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: 280,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('eventservice')
                              .where('title', isEqualTo: 'Event Decoration')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ServiceDetailsScreenUser(

                                                        id: snapshot.data!
                                                            .docs[index]['id'],
                                                        title: snapshot.data!
                                                            .docs[index]['title'],
                                                        description: snapshot
                                                            .data!
                                                            .docs[index]['description'],
                                                        phone: snapshot.data!
                                                            .docs[index]['phone'],
                                                        pin: snapshot.data!
                                                            .docs[index]['pin'],
                                                        location: snapshot.data!
                                                            .docs[index]['place'],
                                                        eventname: snapshot
                                                            .data!
                                                            .docs[index]['eventname'],
                                                        customerid: widget.id,
                                                        customerPhone: widget
                                                            .phone,
                                                        cutomername: widget
                                                            .fname,
                                                        eventmanagerid: snapshot
                                                            .data!
                                                            .docs[index]['eventmanagerid'],
                                                        imgurl: snapshot.data!
                                                            .docs[index]['imgurl'],

                                                      )));
                                        },
                                        child: Card(
                                          elevation: 5.0,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 270,
                                                width: 250,
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 200,
                                                      width: 250,

                                                      // color: Colors.green,
                                                      child: snapshot.data!
                                                          .docs[index]
                                                      ['imgurl'] ==
                                                          null
                                                          ? Image.asset(
                                                        'assets/images/eventmanagement1.jpg)',
                                                        fit: BoxFit.cover,
                                                      )
                                                          : Image.network(
                                                          snapshot.data!
                                                              .docs[index]
                                                          ['imgurl'],
                                                          fit: BoxFit.cover),
                                                    ),
                                                    Container(
                                                      height: 70,
                                                      width: size.width,

                                                      //color: Colors.green,

                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                            //color:Colors.blueGrey,
                                                            width: 150,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                AppText(
                                                                  text: snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  ['eventname'],
                                                                  size: 18,
                                                                ),
                                                                AppText(
                                                                  text: snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  ['place'],
                                                                  size: 14,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                                  child: Center(
                                                      child: AppText(
                                                        text: "Book Now",
                                                        size: 16,
                                                        fw: FontWeight.w500,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                            ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
