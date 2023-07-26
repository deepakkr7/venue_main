import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class AudPayments extends StatefulWidget {
  String?audid;
 AudPayments({Key? key,this.audid}) : super(key: key);

  @override
  State<AudPayments> createState() => _AudPaymentsState();
}

class _AudPaymentsState extends State<AudPayments> {
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

              AppText(text: "View All Payments",size: 24,),
              SizedBox(height: 20,),

              Container(
                  height: MediaQuery.of(context).size.height*0.80,
                  width: MediaQuery.of(context).size.width,

                  child:StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('payment').where('audid',isEqualTo: widget.audid).snapshots(),

                    builder: (context,snapshot){

                      if(snapshot.hasData){

                        return ListView.builder(

                            itemCount:snapshot.data!.docs.length,
                            itemBuilder: (context,index){


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
                                      title: AppText(text: snapshot.data!.docs[index]['customername'],size: 18,),
                                      subtitle: AppText(text: "Amount: Rs.${snapshot.data!.docs[index]['amount']}/-",size: 16,fw: FontWeight.w500,),
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
}
