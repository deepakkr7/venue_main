import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class EventFeedbacks extends StatefulWidget {
  const EventFeedbacks({Key? key}) : super(key: key);

  @override
  State<EventFeedbacks> createState() => _EventFeedbacksState();
}

class _EventFeedbacksState extends State<EventFeedbacks> {
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

              AppText(text: "View All Feedbacks",size: 24,),
              SizedBox(height: 20,),

              Container(
                  height: MediaQuery.of(context).size.height*0.80,
                  width: MediaQuery.of(context).size.width,

                  child:ListView.builder(

                      itemCount: 10,
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
                                title: AppText(text: "Event 1",size: 18,),
                                subtitle: AppText(text: "Details",size: 16,),
                              ),
                            ),
                          ),
                        );
                      })
              ),

              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
