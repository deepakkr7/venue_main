import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';


class ManageAuditoriums extends StatefulWidget {
  const ManageAuditoriums({Key? key}) : super(key: key);

  @override
  State<ManageAuditoriums> createState() => _ManageAuditoriumsState();
}

class _ManageAuditoriumsState extends State<ManageAuditoriums> {

  TextEditingController audidController=TextEditingController();
  TextEditingController auddetailsController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add Auditorium'),
              content: Container(
                height: 130,
                child: Column(
                  children: [

                    TextFormField(
                      controller: audidController,
                      decoration: InputDecoration(
                          hintText: "Auditorium ID"
                      ),
                    ),
                    TextFormField(
                      controller: auddetailsController,
                      decoration: InputDecoration(
                          hintText: "Auditorium Details"
                      ),
                    )


                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {

                    Navigator.pop(context);

                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );



        },
        child: Icon(
            Icons.add
        ),
      ),

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

              AppText(text: "View All Auditoriums",size: 24,),
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
