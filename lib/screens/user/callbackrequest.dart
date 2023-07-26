import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';


class ViewCAllbackRequest extends StatefulWidget {
  String?id;
  ViewCAllbackRequest({Key? key,this.id}) : super(key: key);

  @override
  State<ViewCAllbackRequest> createState() => _ViewCAllbackRequestState();
}

class _ViewCAllbackRequestState extends State<ViewCAllbackRequest> {
  @override
  Widget build(BuildContext context) {
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

              AppText(text: "View All Requests"),
              SizedBox(height: 24,),

              Container(
                  height: MediaQuery.of(context).size.height*0.80,
                  width: MediaQuery.of(context).size.width,

                  child:StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('servicecallback').where('customerid',isEqualTo:widget.id.toString() ).snapshots(),

                  builder: (_,snapshot){



                      if(snapshot.hasData){

                        return ListView.builder(

                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                            var date=  formatTimestamp(snapshot.data!.docs[index]['createdat']);

                              return  Card(
                                elevation: 5.0,
                                child: Container(
                                  height: 100,
                                  child: Center(
                                    child: ListTile(

                                      leading: CircleAvatar(
                                        child: Center(
                                          child: Text(
                                              (index+1).toString()
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(

                                        onPressed: (){},

                                        icon: Icon(Icons.arrow_forward_ios),
                                      ),
                                      title: AppText(text: snapshot.data!.docs[index]['eventname'],size: 16,
                                      ),
                                      subtitle: AppText(text:date.toString() ),
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

                  )
              ),

              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('y-M-d'); // <- use skeleton here
    return format.format(timestamp.toDate());
  }
}
