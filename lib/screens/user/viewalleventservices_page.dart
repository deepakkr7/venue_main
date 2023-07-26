import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/detailscreen.dart';
import 'package:venue/screens/user/eventservicedetails.dart';
import 'package:venue/utilities/apptext.dart';


class ViewAllEventServiceUSer extends StatefulWidget {

  String?customerid;
  String?cutomername;
  String?customerPhone;
  String?title;
  ViewAllEventServiceUSer({Key? key,this.cutomername,this.customerid,this.customerPhone,this.title}) : super(key: key);

  @override
  State<ViewAllEventServiceUSer> createState() => _ViewAllEventServiceUSerState();
}

class _ViewAllEventServiceUSerState extends State<ViewAllEventServiceUSer> {

  List<String> categories = ["Photography", "Catering Service", "Event Decoration"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,


        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              AppText(text: "View All Services"),
              SizedBox(height: 20,),

              Container(
                  height: size.height*0.75,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('eventservice')

                        .where('status', isEqualTo: 1).where('title',isEqualTo: widget.title)
                        .snapshots(),
                    builder: (context, snapshot) {




                     if (snapshot.hasData){
                       return ListView.builder(

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
                                                 imgurl: snapshot.data!.docs[index]['imgurl'],
                                                 eventname: snapshot.data!.docs[index]['eventname'],
                                                 id: snapshot.data!.docs[index]['id'],
                                                 title: snapshot.data!.docs[index]['title'],
                                                 description: snapshot.data!.docs[index]['description'],
                                                 phone: snapshot.data!.docs[index]['phone'],
                                                 pin: snapshot.data!.docs[index]['pin'],
                                                 location: snapshot.data!.docs[index]['place'],
                                                 customerid: widget.customerid,
                                                 customerPhone: widget.customerPhone,
                                                 cutomername: widget.cutomername,
                                                 eventmanagerid: snapshot.data!.docs[index]['eventmanagerid'],

                                               )));
                                 },
                                 child: Card(
                                   elevation: 5.0,
                                   child: Stack(
                                     children: [
                                       Container(
                                         height: 270,

                                         color: Colors.white,
                                         child: Column(
                                           crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                           children: [
                                             Container(

                                               height: 200,


                                               decoration: BoxDecoration(
                                                   image: DecorationImage(
                                                       fit: BoxFit.cover,
                                                       image: NetworkImage(
                                                         snapshot.data!
                                                             .docs[index]
                                                         ['imgurl'],

                                                       )
                                                   )
                                               ),
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
                                         bottom: 10,
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

              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
