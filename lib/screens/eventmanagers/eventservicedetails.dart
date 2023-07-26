import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class EventServiceDetails extends StatefulWidget {

  String?title;
String?description;
String?id;
String?eventmanagerid;


 EventServiceDetails({Key? key,this.id,this.description,this.eventmanagerid,this.title}) : super(key: key);

  @override
  State<EventServiceDetails> createState() => _EventServiceDetailsState();
}

class _EventServiceDetailsState extends State<EventServiceDetails> {

  TextEditingController eventserviceController=TextEditingController();
  TextEditingController eventservicedetailsController=TextEditingController();

  @override
  initState(){
    eventservicedetailsController.text=widget.description.toString();
    eventserviceController.text=widget.title.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        title: Text("Edit Service Details"),
      ),
      body:  Container(
        height: double.infinity,
        color: Colors.white70,
        
        child: Card(
          child: Container( 
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(25),
            height:100,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [

                AppText(text: "Service Details",size: 24,),
SizedBox(height: 30,),
                TextFormField(
                  controller: eventserviceController,
                  decoration: InputDecoration(
                      hintText: "Service ID"
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  controller: eventservicedetailsController,
                  decoration: InputDecoration(
                      hintText: "Service Details"
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(


                  onTap: (){


                    print(widget.id.toString());

                    FirebaseFirestore.instance.collection('eventservice').doc(widget.id.toString()).update({



                      'title':eventserviceController.text,
                      'description':eventservicedetailsController.text,


                    }).then((value) =>Navigator.pop(context));

                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: AppText(text: "Update",color: Colors.white,size: 20,fw: FontWeight.w700,),
                      ),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),

    );
  }
}
