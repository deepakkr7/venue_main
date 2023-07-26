import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DetailsPage extends StatefulWidget {
  String? customerid;
  String? cutomername;
  String? customerPhone;
  String? name;
  String? id;
  String? img;
  var facility;
  String? email;
  String? phone;
  String? pin;
  String? location;
  DetailsPage(
      {Key? key,
      this.cutomername,
      this.customerPhone,
      this.customerid,
      this.facility,
      this.email,
      this.pin,
      this.img,
      this.name,
      this.id,
      this.phone,
      this.location})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController datecontroller = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();

  String _date = "Not set";
  String _time = "Not set";
  String? time;
  List<String> timeslots = ["Full day", "half day(Lunch)", "Half day(Dinner)"];

  var _facilities = [];
  String? msg;

  String? _setTime, _setDate;

  String? dateTime;

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController2 = TextEditingController();

  var uuid = Uuid();
  var docid;

  @override
  initState() {
    docid = uuid.v1();
    _facilities.addAll(widget.facility);
    _dateController.text = DateFormat.yMd().format(DateTime.now());
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.green,
                height: MediaQuery.of(context).size.height / 2,
                child: Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.img.toString(),
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Container(
                        child: AppText(
                          text: widget.name,
                          color: Colors.white,
                          size: 24,
                          fw: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Contact Details",
                        size: 20,
                        fw: FontWeight.w500,
                      ),
                      SizedBox(height: 10),
                      Card(
                        color: Colors.white70,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            UrlLauncher.launch(
                                                'tel:+${widget.phone.toString()}');
                                          },
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(widget.phone.toString())
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.email,
                                            color: Colors.green,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(widget.email.toString())
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppText(
                        text: "Facilities",
                        size: 20,
                        fw: FontWeight.w500,
                      ),
                      Container(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _facilities.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(label: Text(_facilities[index])),
                                );
                              })),
                      SizedBox(height: 10),
                      AppText(
                        text: "Available Packages",
                        size: 20,
                        fw: FontWeight.w500,
                      ),
                      SizedBox(height: 10),
                      Container(
                          height: 180,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('packages')
                                .where('uid', isEqualTo: widget.id)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.docs.length == 0) {
                                return Center(
                                  child: Text("No Packages Available"),
                                );
                              }

                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          elevation: 5.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            height: 150,
                                            width: 250,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    color: btnColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  height: 100,
                                                  width: 250,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AppText(
                                                            text: snapshot.data!
                                                                    .docs[index]
                                                                ['title'],
                                                            size: 22,
                                                            fw: FontWeight.bold,
                                                          ),
                                                          AppText(
                                                            text: snapshot.data!
                                                                    .docs[index]
                                                                ['description'],
                                                            size: 16,
                                                            fw: FontWeight.w500,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 120,
                                                        //color: Colors.red,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            AppText(
                                                              text:
                                                                  "RS.${snapshot.data!.docs[index]['price']}/-",
                                                              size: 20,
                                                              fw: FontWeight
                                                                  .w700,
                                                            ),
                                                            snapshot.data!.docs[
                                                                            index]
                                                                        [
                                                                        'offer'] !=
                                                                    "0"
                                                                ? AppText(
                                                                    text:
                                                                        "Offer.${snapshot.data!.docs[index]['offer']}%",
                                                                    size: 18,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                ),
                                                Center(
                                                    child: InkWell(
                                                        onTap: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Request Send'),
                                                              content:
                                                                  Container(
                                                                //color: Colors.red,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    2,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Form(
                                                                    key: _key,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(
                                                                              child: Container(
                                                                                width: 120,
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return "Select a valid Date";
                                                                                    }
                                                                                  },
                                                                                  style: TextStyle(fontSize: 16),
                                                                                  enabled: false,
                                                                                  keyboardType: TextInputType.text,
                                                                                  controller: _dateController2,
                                                                                  onSaved: (String? val) {
                                                                                    _setDate = val!;
                                                                                  },
                                                                                  decoration: InputDecoration(disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none), hintText: "Select Date", contentPadding: EdgeInsets.only(top: 0.0)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                var picked = await showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: DateTime.now(),
                                                                                  initialDatePickerMode: DatePickerMode.day,
                                                                                  firstDate:DateTime.now(),
                                                                                  lastDate: DateTime(2101),
                                                                                );
                                                                                if (picked != null)
                                                                                  setState(() {
                                                                                    selectedDate2 = picked;
                                                                                    if (selectedDate2.isAfter(DateTime.now())) {
                                                                                      _dateController2.text = DateFormat.yMd().format(selectedDate2);
                                                                                    } else {
                                                                                      setState(() {
                                                                                        msg = "Hello";
                                                                                      });
                                                                                    }
                                                                                  });
                                                                              },
                                                                              child: Icon(Icons.calendar_month),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        DropdownButtonFormField(
                                                                          items:
                                                                              timeslots.map((String time) {
                                                                            return new DropdownMenuItem<String>(
                                                                                value: time,
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    Text(time),
                                                                                  ],
                                                                                ));
                                                                          }).toList(),
                                                                          onChanged:
                                                                              (String? value) {
                                                                            // do other stuff with time
                                                                            setState(() =>
                                                                                time = value);
                                                                          },
                                                                          value:
                                                                              time,
                                                                          decoration: InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(),
                                                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: btnColor, width: 3)),
                                                                              hintText: 'Time Slot'),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        TextFormField(
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Select a valid Message";
                                                                            }
                                                                          },
                                                                          controller:
                                                                              commentcontroller,
                                                                          maxLines:
                                                                              5,
                                                                          decoration: InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(),
                                                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: btnColor, width: 3)),
                                                                              hintText: "Comments"),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (_key.currentState!.validate()) {
                                                                              if (time != null) {
                                                                                FirebaseFirestore.instance.collection('bookings').doc(docid).set({
                                                                                  'audname': widget.name,
                                                                                  'bookingid': docid,
                                                                                  'bookingDate': _dateController2.text,
                                                                                  'session': time,
                                                                                  'audid': widget.id,
                                                                                  'comments': commentcontroller.text,
                                                                                  'status': 0,
                                                                                  'packageid': snapshot.data!.docs[index]['packageId'],
                                                                                  'reply': "",
                                                                                  'replystatus': 0,
                                                                                  'customerid': widget.customerid,
                                                                                  'paymentstatus': 0,
                                                                                  'paymentamount': snapshot.data!.docs[index]['price']
                                                                                }).then((value) {
                                                                                  Navigator.pop(context);
                                                                                });
                                                                              } else {
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a Time Slot")));
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Text('OK'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <
                                                                  Widget>[],
                                                            ),
                                                          );
                                                        },
                                                        child: AppText(
                                                          text: "Book Now",
                                                          color: Colors.white,
                                                          size: 24,
                                                          fw: FontWeight.w500,
                                                        ))),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }

                              if (snapshot.hasError) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Center(
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       height: 45,
              //       width: 150,
              //       decoration: BoxDecoration(
              //           color: btnColor,
              //           borderRadius: BorderRadius.circular(12)),
              //       child: Center(
              //           child: AppText(
              //         text: "Book Now",
              //         size: 20,
              //         color: Colors.black,
              //         fw: FontWeight.w600,
              //       )),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
