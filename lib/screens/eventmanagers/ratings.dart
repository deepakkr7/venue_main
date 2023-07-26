import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';


class RatingsView extends StatefulWidget {
  String?id;
   RatingsView({Key? key,this.id
  }) : super(key: key);

  @override
  State<RatingsView> createState() => _RatingsViewState();
}

class _RatingsViewState extends State<RatingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: btnColor,),

      body:  Container(

          height: MediaQuery.of(context).size.height * 0.75,
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
                          padding: EdgeInsets.all(10),

                          height: 250,
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
                                                      Row(
                                                        children: [
                                                          AppText(text: 'Eventname:',size: 16,fw: FontWeight.w500,),
                                                          AppText(
                                                            text: feed[index]['eventname'], color: Colors.black87,
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
                                                        48,
                                                          width: MediaQuery.of(context).size.width ,
                                                          child:StreamBuilder<QuerySnapshot>(
                                                            stream: FirebaseFirestore.instance.collection('rating').where('feedbackid',isEqualTo:feed[index]
                                                            [
                                                            'callbackid'] ).snapshots(),

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

                                                              return Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            },
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
