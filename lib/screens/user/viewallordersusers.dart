import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/paymentpage.dart';
import 'package:venue/utilities/apptext.dart';

class ViewAllOrdersUser extends StatefulWidget {
  var email;
  var fname;
  var lname;
  var pin;
  var place;
  var id;
  var phone;
  String? imgurl_pref;

  ViewAllOrdersUser(
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
  State<ViewAllOrdersUser> createState() => _ViewAllOrdersUserState();
}

class _ViewAllOrdersUserState extends State<ViewAllOrdersUser>
    with SingleTickerProviderStateMixin {
  var email;
  var fname;
  var lname;
  var pin;
  var place;
  var id;
  var phone;
  var img;

  var imgurl;
  setData() {
    email = widget.email;
    fname = widget.fname;
    lname = widget.lname;
    pin = widget.pin;
    place = widget.place;
    id = widget.id;
    phone = widget.phone;
    img = widget.imgurl_pref;
  }

  TabController? _tabController;
  TextEditingController replyController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  final key = GlobalKey<FormState>();
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;
  var ratings;
  @override
  void initState() {
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
    setData();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // give the tab bar a height [can change height to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                color: Colors.green,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Services',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Bookings',
                ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "All Bookings",
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                            height:MediaQuery.of(context).size.height,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('servicecallback')
                                  .where('customerid', isEqualTo: widget.id)
                                  .snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  List<QueryDocumentSnapshot> feed =
                                      snapshot.data!.docs;

                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            height: 250,
                                            //color: Colors.red,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment(0.0, 0.0),
                                                  child: Card(
                                                    elevation: 5.0,
                                                    child: Container(
                                                        //color: Colors.red,
                                                        height: 250,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment(
                                                                      -0.9,
                                                                      0.0),
                                                              child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  //color: Colors.grey,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      160,
                                                                  height: 180,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          AppText(
                                                                            text:
                                                                                'Eventname:',
                                                                            size:
                                                                                16,
                                                                            fw: FontWeight.w500,
                                                                          ),
                                                                          AppText(
                                                                            text:
                                                                                feed[index]['eventname'],
                                                                            color:
                                                                                Colors.black87,
                                                                          ),
                                                                          // AppText(
                                                                          //  text: feed[index]
                                                                          //   ['storename'],
                                                                          //  color: Colors
                                                                          //       .black45,
                                                                          //   size: 12,
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                      AppText(
                                                                        text: feed[index]
                                                                            [
                                                                            'servicetype'],
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      AppText(
                                                                        text: feed[index]
                                                                            [
                                                                            'session'],
                                                                        color: Colors
                                                                            .black45,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                      AppText(
                                                                        text: feed[index]
                                                                            [
                                                                            'comment'],
                                                                        color: Colors
                                                                            .black45,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                      AppText(
                                                                        text: feed[index]
                                                                            [
                                                                            'date'],
                                                                        color: Colors
                                                                            .black45,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                      Container(
                                                                          height:
                                                                              40,
                                                                          width: MediaQuery.of(context).size.width -
                                                                              160,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              feed[index]['callstatus'] == 1
                                                                                  ? AppText(
                                                                                      text: "Contacted",
                                                                                      size: 16,
                                                                                      fw: FontWeight.w700,
                                                                                      color: Colors.green,
                                                                                    )
                                                                                  : AppText(
                                                                                      text: "Pending",
                                                                                      size: 16,
                                                                                      fw: FontWeight.w700,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                              Container(
                                                                                  child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  feed[index]['callstatus'] == 1
                                                                                      ? IconButton(
                                                                                          onPressed: () {
                                                                                            showDialog<void>(
                                                                                              context: context,
                                                                                              builder: (BuildContext context) {
                                                                                                return AlertDialog(
                                                                                                  title: const Text('Write feedback'),
                                                                                                  content: Container(
                                                                                                    height: 180,
                                                                                                    child: Form(
                                                                                                      key: key,
                                                                                                      child: Column(
                                                                                                        children: [
                                                                                                          TextFormField(
                                                                                                            controller: replyController,
                                                                                                            validator: (value) {
                                                                                                              if (value!.isEmpty) {
                                                                                                                return "feedback cannot be empty";
                                                                                                              }
                                                                                                            },
                                                                                                            decoration: InputDecoration(errorStyle: TextStyle(color: Colors.black), hintText: "Feedback Message"),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 20,
                                                                                                          ),
                                                                                                          RatingBar.builder(
                                                                                                            initialRating: 3,
                                                                                                            minRating: 1,
                                                                                                            direction: Axis.horizontal,
                                                                                                            allowHalfRating: true,
                                                                                                            itemCount: 5,
                                                                                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                                                            itemBuilder: (context, _) => Icon(
                                                                                                              Icons.star,
                                                                                                              color: Colors.amber,
                                                                                                            ),
                                                                                                            onRatingUpdate: (rating) {
                                                                                                              print(rating);
                                                                                                              setState(() {
                                                                                                                ratings = rating;
                                                                                                              });
                                                                                                            },
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  actions: <Widget>[
                                                                                                    TextButton(
                                                                                                      style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white), backgroundColor: btnColor),
                                                                                                      child: const Text('Cancel'),
                                                                                                      onPressed: () {
                                                                                                        Navigator.of(context).pop();
                                                                                                      },
                                                                                                    ),
                                                                                                    TextButton(
                                                                                                      style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white), backgroundColor: btnColor),
                                                                                                      child: const Text('Send Feedback'),
                                                                                                      onPressed: () {
                                                                                                        if (key.currentState!.validate()) {
                                                                                                          FirebaseFirestore.instance.collection('rating').doc(feed[index]['callbackid']).set({
                                                                                                            'feedback': replyController.text,
                                                                                                            'feedbackid': feed[index]['callbackid'],
                                                                                                            'customername': feed[index]['customerid'],
                                                                                                            'status': replyController.text,
                                                                                                            'rating': ratings,
                                                                                                            'userid': feed[index]['customerid'],
                                                                                                            'managerid': feed[index]['managerid']
                                                                                                          }).then((value) {
                                                                                                            Navigator.pop(context);
                                                                                                          });
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: Icon(
                                                                                            Icons.message_sharp,
                                                                                            color: Colors.green,
                                                                                          ))
                                                                                      : SizedBox.shrink()
                                                                                ],
                                                                              )),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  )),
                                                            ),
                                                            // Positioned(
                                                            //   top: 50,
                                                            //   left: 0,
                                                            //   bottom: 50,
                                                            //   child: Container(
                                                            //     height: 20,
                                                            //     width: 30,
                                                            //     decoration: BoxDecoration(
                                                            //       color: primaryColor.withOpacity(0.5),
                                                            //       shape: BoxShape.rectangle
                                                            //     ),
                                                            //     child: Center(child: Text((index+1).toString())),
                                                            //   ),
                                                            // )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ],
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
                      )
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "All Bookings",
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height ,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('bookings')
                                    .where('customerid', isEqualTo: widget.id)
                                    .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    List<QueryDocumentSnapshot> feed =
                                        snapshot.data!.docs;

                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (_, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Container(
                                              
                                              height: 230,
                                              //color: Colors.red,
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment(0.0, 0.0),
                                                    child: Card(
                                                      elevation: 5.0,
                                                      child: Container(
                                                          //color: Colors.red,
                                                          height: 150,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -0.9,
                                                                        0.0),
                                                                child: Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                10),
                                                                    //color: Colors.grey,
                                                                    width: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width ,

                                                                    height: 180,
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AppText(
                                                                          text: feed[index]
                                                                              [
                                                                              'audname'],
                                                                          color: Colors
                                                                              .black87,
                                                                        ),
                                                                        AppText(
                                                                          text: feed[index]
                                                                              [
                                                                              'bookingDate'],
                                                                          color: Colors
                                                                              .black87,
                                                                          size:
                                                                              18,
                                                                        ),
                                                                        AppText(
                                                                          text: feed[index]
                                                                              [
                                                                              'comments'],
                                                                          color: Colors
                                                                              .black45,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        AppText(
                                                                          text: feed[index]
                                                                              [
                                                                              'session'],
                                                                          color: Colors
                                                                              .black45,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        Container(

                                                                            height:
                                                                              40,
                                                                            width: MediaQuery.of(context).size.width ,

                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                feed[index]['replystatus'] == 1
                                                                                    ? AppText(
                                                                                        text: "Replied",
                                                                                        size: 16,
                                                                                        fw: FontWeight.w700,
                                                                                        color: Colors.green,
                                                                                      )
                                                                                    :
                                                                                feed[index]['replystatus']==0&&feed[index]['status']==1?AppText(text: "Rejected",size: 16,color: Colors.red,fw: FontWeight.w700):
                                                                                AppText(
                                                                                  text: "Not Replied",
                                                                                  size: 16,
                                                                                  fw: FontWeight.w700,
                                                                                  color: Colors.red,
                                                                                ),

                                                                                feed[index]['replystatus'] == 1 && feed[index]['paymentstatus'] == 0
                                                                                    ? InkWell(
                                                                                        onTap: () {
                                                                                          Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                              builder: (context) => CrediCardClass(
                                                                                                email: email,
                                                                                                fname: fname,
                                                                                                lname: lname,
                                                                                                pin: pin,
                                                                                                place: place,
                                                                                                id: id,
                                                                                                phone: phone,
                                                                                                imgurl_pref: img,
                                                                                                item: snapshot.data!.docs[index],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: AppText(
                                                                                          text: "Pay Now",
                                                                                          size: 16,
                                                                                          fw: FontWeight.w700,
                                                                                          color: Colors.green,
                                                                                        ),
                                                                                      )
                                                                                    : feed[index]['replystatus'] == 1 && feed[index]['paymentstatus'] == 1
                                                                                        ? Row(
                                                                                          children: [
                                                                                            AppText(
                                                                                                text: "Payment Done",
                                                                                                size: 16,
                                                                                              ),
                                                                                            Container(

                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    feed[index]['paymentstatus'] == 1
                                                                                                        ? IconButton(
                                                                                                        onPressed: () {
                                                                                                          showDialog<void>(
                                                                                                            context: context,
                                                                                                            builder: (BuildContext context) {
                                                                                                              return AlertDialog(
                                                                                                                title: const Text('Write feedback'),
                                                                                                                content: Container(
                                                                                                                  height: 180,
                                                                                                                  child: Form(
                                                                                                                    key: key,
                                                                                                                    child: Column(
                                                                                                                      children: [
                                                                                                                        TextFormField(
                                                                                                                          controller: replyController,
                                                                                                                          validator: (value) {
                                                                                                                            if (value!.isEmpty) {
                                                                                                                              return "feedback cannot be empty";
                                                                                                                            }
                                                                                                                          },
                                                                                                                          decoration: InputDecoration(errorStyle: TextStyle(color: Colors.black), hintText: "Feedback Message"),
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                          height: 20,
                                                                                                                        ),
                                                                                                                        RatingBar.builder(
                                                                                                                          initialRating: 3,
                                                                                                                          minRating: 1,
                                                                                                                          direction: Axis.horizontal,
                                                                                                                          allowHalfRating: true,
                                                                                                                          itemCount: 5,
                                                                                                                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                                                                          itemBuilder: (context, _) => Icon(
                                                                                                                            Icons.star,
                                                                                                                            color: Colors.amber,
                                                                                                                          ),
                                                                                                                          onRatingUpdate: (rating) {
                                                                                                                            print(rating);
                                                                                                                            setState(() {
                                                                                                                              ratings = rating;
                                                                                                                            });
                                                                                                                          },
                                                                                                                        )
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                actions: <Widget>[
                                                                                                                  TextButton(
                                                                                                                    style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white), backgroundColor: btnColor),
                                                                                                                    child: const Text('Cancel'),
                                                                                                                    onPressed: () {
                                                                                                                      Navigator.of(context).pop();
                                                                                                                    },
                                                                                                                  ),
                                                                                                                  TextButton(
                                                                                                                    style: TextButton.styleFrom(textStyle: TextStyle(color: Colors.white), backgroundColor: btnColor),
                                                                                                                    child: const Text('Send Feedback'),
                                                                                                                    onPressed: () {
                                                                                                                      if (key.currentState!.validate()) {
                                                                                                                        FirebaseFirestore.instance.collection('audrating').doc(feed[index]['bookingid']).set({
                                                                                                                          'feedback': replyController.text,
                                                                                                                          'feedbackid': feed[index]['bookingid'],
                                                                                                                          'status': replyController.text,
                                                                                                                          'rating': ratings,
                                                                                                                          'userid': feed[index]['customerid'],
                                                                                                                          'audid': feed[index]['audid']
                                                                                                                        }).then((value) {
                                                                                                                          replyController.clear();
                                                                                                                          Navigator.pop(context);
                                                                                                                        });
                                                                                                                      }
                                                                                                                    },
                                                                                                                  ),
                                                                                                                ],
                                                                                                              );
                                                                                                            },
                                                                                                          );
                                                                                                        },
                                                                                                        icon: Icon(
                                                                                                          Icons.message_sharp,
                                                                                                          color: Colors.green,
                                                                                                        ))
                                                                                                        : SizedBox.shrink()
                                                                                                  ],
                                                                                                )),
                                                                                          ],
                                                                                        ):SizedBox()


                                                                              ],
                                                                            )



                                                                        ),
                                                                      ],
                                                                    )),
                                                              ),
                                                              // Positioned(
                                                              //   top: 50,
                                                              //   left: 0,
                                                              //   bottom: 50,
                                                              //   child: Container(
                                                              //     height: 20,
                                                              //     width: 30,
                                                              //     decoration: BoxDecoration(
                                                              //       color: primaryColor.withOpacity(0.5),
                                                              //       shape: BoxShape.rectangle
                                                              //     ),
                                                              //     child: Center(child: Text((index+1).toString())),
                                                              //   ),
                                                              // )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
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
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
