import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';


class RatingsViewAud extends StatefulWidget {
  String?id;
  RatingsViewAud({Key? key,this.id
  }) : super(key: key);

  @override
  State<RatingsViewAud> createState() => _RatingsViewAudState();
}

class _RatingsViewAudState extends State<RatingsViewAud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: btnColor,),

        body:  Container(
          padding: EdgeInsets.all(20),

            height: MediaQuery.of(context).size.height * 0.75,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bookings')
                  .where('audid', isEqualTo: widget.id).where('paymentstatus',isEqualTo: 1)
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


                        

                            height:180,
                            //color: Colors.red,
                            child: Stack(
                              children: [
                                Align(
                                  alignment:
                                  Alignment(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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



                                                        SizedBox(height: 10,),

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
                                                          'comments'],
                                                          color: Colors
                                                              .black45,
                                                          size:
                                                          16,
                                                        ),

                                                        AppText(
                                                          text: feed[index]
                                                          [
                                                          'bookingDate'],
                                                          color: Colors
                                                              .black45,
                                                          size:
                                                          16,
                                                        ),

                                                        feed[index]
                                                        [
                                                        'paymentstatus']==1?    Container(

                                                            height:
                                                            48,
                                                            width: MediaQuery.of(context).size.width ,
                                                            child:StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance.collection('audrating').where('audid',isEqualTo:feed[index]
                                                              [
                                                              'audid'] ).snapshots(),

                                                              builder: (context,snapshot){



                                                                if(snapshot.hasData){

                                                                  print(snapshot.data!.docs[0]['rating']);
                                                                  return  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Expanded(
                                                                        child: RatingBar.builder(
                                                                          itemSize: 30
                                                                          ,
                                                                          ignoreGestures: true,
                                                                          initialRating:double.parse(snapshot.data!.docs[0]['rating'].toString()),
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
                                                                          },
                                                                        ),
                                                                      ),
                                                                      AppText(text: snapshot.data!.docs[0]['feedback'],size: 18,)
                                                                    ],
                                                                  );
                                                                }
                                                                if(!snapshot.hasError){

                                                                  return Center(child: Text("No Feed backs"),);
                                                                }




                                                                return Center(
                                                                  child: CircularProgressIndicator(),
                                                                );
                                                              },
                                                            )


                                                        ):SizedBox(),





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
            ))
    );
  }
}
