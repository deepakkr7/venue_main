import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class ViewAllEventBooking extends StatefulWidget {
  String?id;
  ViewAllEventBooking({
    Key? key,this.id
  }) : super(key: key);

  @override
  State<ViewAllEventBooking> createState() => _ViewAllEventBookingState();
}

class _ViewAllEventBookingState extends State<ViewAllEventBooking> {

  TextEditingController replyController=TextEditingController();
  final key=GlobalKey<FormState>();

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
      body:    Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('servicecallback')
                .where('managerid', isEqualTo: widget.id)
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
                          height: 200,
                          //color: Colors.red,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(0.0, 0.0),
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(

                                      height: 150,
                                      width:
                                      MediaQuery.of(context)
                                          .size
                                          .width,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                            Alignment(
                                                -0.9, 0.0),
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
                                                      text: feed[
                                                      index]
                                                      [
                                                      'session'],
                                                      color: Colors
                                                          .black87,
                                                    ),
                                                    AppText(
                                                      text: feed[
                                                      index]
                                                      [
                                                      'comment'],
                                                      color: Colors
                                                          .black45,
                                                      size: 12,
                                                    ),
                                                    AppText(
                                                      text: feed[
                                                      index]
                                                      [
                                                      'date'],
                                                      color: Colors
                                                          .black45,
                                                      size: 12,
                                                    ),
                                                    Container(


                                                        height:
                                                        40,
                                                        width: MediaQuery.of(context).size.width,

                                                        child:
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            feed[index]['callstatus'] == 1
                                                                ? AppText(
                                                              text: "Called",
                                                              size: 16,
                                                              fw: FontWeight.w700,
                                                              color: Colors.green,
                                                            )
                                                                : AppText(
                                                              text:replyController.text,
                                                              size: 16,
                                                              fw: FontWeight.w700,
                                                              color: Colors.green,
                                                            ),

                                                            feed[index]['callstatus'] ==
                                                                0
                                                                ? IconButton(
                                                                onPressed:
                                                                    () {
                                                                  showDialog<void>(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Text('Send Reply'),
                                                                        content: Container(
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

                                                                                  decoration: InputDecoration(
                                                                                      errorStyle: TextStyle(color: Colors.black),

                                                                                      hintText: "Reply Message"),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        actions: <Widget>[

                                                                          TextButton(
                                                                            style: TextButton.styleFrom(
                                                                                textStyle: TextStyle(color: Colors.white),

                                                                                backgroundColor: btnColor
                                                                            ),
                                                                            child: const Text('Cancel'),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          TextButton(
                                                                            style: TextButton.styleFrom(
                                                                                textStyle: TextStyle(color: Colors.white),

                                                                                backgroundColor: btnColor
                                                                            ),
                                                                            child: const Text('Send Reply'),
                                                                            onPressed: () {
                                                                              if(key.currentState!.validate()){

                                                                                FirebaseFirestore.instance.collection('servicecallback').doc(feed[index]['callbackid']).update({

                                                                                  'replystatus':1,
                                                                                  'callstatus':1,
                                                                                  'reply':replyController.text
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
                                                                icon:
                                                                Icon(
                                                                  Icons.message_sharp,
                                                                  color: Colors.green,
                                                                ))
                                                                : SizedBox.shrink(),

                                                            Container(
                                                              width: 150,
                                                              child: Row(
                                                                children: [
                                                                  InkWell(

                                                                    onTap:(){

                                                                      UrlLauncher.launch(
                                                                          'tel:+${ feed[index]['customerphone'].toString()}');



                                                                    },
                                                                      child: Icon(Icons.call)),
                                                                  SizedBox(width: 10,),
                                                                  AppText(
                                                                    text: feed[
                                                                    index]
                                                                    [
                                                                    'customerphone'],
                                                                    color: Colors
                                                                        .black45,
                                                                    size: 12,
                                                                  ),

                                                                ],
                                                              ),
                                                            ),


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
