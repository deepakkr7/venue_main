import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class ViewAllAudBooking extends StatefulWidget {
  String? id;
  ViewAllAudBooking({Key? key, this.id}) : super(key: key);

  @override
  State<ViewAllAudBooking> createState() => _ViewAllAudBookingState();
}

class _ViewAllAudBookingState extends State<ViewAllAudBooking> {
  TextEditingController replyController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    replyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('bookings')
                .where('audid', isEqualTo: widget.id)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> feed = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 200,
                          //color: Colors.red,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0.0, 0.0),
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                      //color: Colors.red,
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [
                                       (   feed[index]['replystatus'] == 1 &&   feed[index]['status']==0 )
                                              ? Positioned(
                                            top: 10,
                                            right: 20,
                                                child: AppText(
                                                    text: "Accepted",
                                                    size: 16,
                                                    fw: FontWeight.w700,
                                                    color: Colors.green,
                                                  ),
                                              )
                                              :   (   feed[index]['replystatus'] == 0 &&   feed[index]['status']==0 )?Positioned(
                                                  top: 0,
                                                  right: 20,
                                                  child: Container(
                                                    height: 42,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        ),
                                                    child: Row(

                                                      children: [
                                                        Text("Reject"),
                                                        IconButton(
                                                            onPressed: () {

                                                              print("clicked");
                                                              FirebaseFirestore.instance.collection('bookings').doc(feed[index]['bookingid']).update({
                                                                'status': 1,

                                                              });

                                                              setState(() {

                                                              });

                                                            },
                                                            icon: Icon(
                                                                Icons.close,color: Colors.red,))
                                                      ],
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                    ),
                                                  ),
                                                ):Positioned(
                                         top: 10,
                                         right: 20,
                                         child: AppText(
                                           text: "Rejected",
                                           size: 16,
                                           fw: FontWeight.w700,
                                           color: Colors.red,
                                         ),
                                       ),
                                          Align(
                                            alignment: Alignment(-0.9, 0.0),
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                //color: Colors.grey,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    160,
                                                height: 180,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                      text: feed[index]
                                                          ['session'],
                                                      color: Colors.black87,
                                                    ),
                                                    AppText(
                                                      text: feed[index]
                                                          ['comments'],
                                                      color: Colors.black45,
                                                      size: 12,
                                                    ),
                                                    AppText(
                                                      text: feed[index]
                                                          ['bookingDate'],
                                                      color: Colors.black45,
                                                      size: 12,
                                                    ),
                                                    Container(
                                                        height: 40,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            160,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                         (   feed[index]['replystatus'] ==
                                                                    1 && feed[index]['status'] ==
                                                             0 )
                                                                ? AppText(
                                                                    text:
                                                                        "Replied",
                                                                    size: 16,
                                                                    fw: FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .green,
                                                                  )
                                                                : (   feed[index]['replystatus'] == 0 &&   feed[index]['status']==1 ) ?AppText(
                                                                    text:
                                                                        "Rejected",
                                                                    size: 16,
                                                                    fw: FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .red,
                                                                  ):
                                                          Row(
                                                            children: [
                                                              AppText(
                                                                text:
                                                                "Accept",
                                                                size: 16,
                                                                fw: FontWeight
                                                                    .w700,
                                                                color: Colors
                                                                    .red,
                                                              ),
                                                              IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          showDialog<
                                                                              void>(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext
                                                                                    context) {
                                                                              return AlertDialog(
                                                                                title:
                                                                                    const Text('Send Reply'),
                                                                                content:
                                                                                    Container(
                                                                                  height: 100,
                                                                                  child: Form(
                                                                                    key: key,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        TextFormField(
                                                                                          controller: replyController,
                                                                                          validator: (value) {
                                                                                            if (value!.isEmpty) {
                                                                                              return "Enter  Valid Days";
                                                                                            }
                                                                                          },
                                                                                          decoration: InputDecoration(errorStyle: TextStyle(color: Colors.black), hintText: "Reply Message"),
                                                                                        ),
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
                                                                                    child: const Text('Send Reply'),
                                                                                    onPressed: () {
                                                                                      if (key.currentState!.validate()) {
                                                                                        FirebaseFirestore.instance.collection('bookings').doc(feed[index]['bookingid']).update({
                                                                                          'replystatus': 1,
                                                                                          'reply': replyController.text
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
                                                                          Icons
                                                                              .message_sharp,
                                                                          color: Colors
                                                                              .green,
                                                                        )),
                                                            ],
                                                          )

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
    );
  }
}
