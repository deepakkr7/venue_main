import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/eventmanagers/addservice.dart';
import 'package:venue/screens/eventmanagers/eventservicedetails.dart';
import 'package:venue/utilities/apptext.dart';

class EventServices extends StatefulWidget {
  var email;
  var eventname;
  var phoneno;
  var pin;
  var place;
  var id;

  EventServices({Key? key,this.email,this.eventname,this.phoneno,this.place,this.pin,this.id}) : super(key: key);
  @override
  State<EventServices> createState() => _EventServicesState();
}

class _EventServicesState extends State<EventServices> {
  String?_category;
  List<String> categories = ["Photography", "Catering Service", "Event Decoration"];
  TextEditingController eventserviceController=TextEditingController();
  TextEditingController eventservicedetailsController=TextEditingController();
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?
  var imageurl;

  var uuid=Uuid();

var serviceid;
  initState(){
    serviceid=uuid.v1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddServices( id: widget.id,
            email: widget.email,
            place: widget.place,
            phoneno: widget.phoneno,
            pin: widget.pin,
            eventname: widget.eventname,
          )));



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

              AppText(text: "View All Services",size: 24,),
              SizedBox(height: 20,),

              Container(
                  height: MediaQuery.of(context).size.height*0.80,
                  width: MediaQuery.of(context).size.width,

                  child:StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('eventservice').where('eventmanagerid',isEqualTo:widget.id).snapshots(),
                    builder: (_,snapshot){
                      
                      if(snapshot.hasData){
                        
                        return ListView.builder(

                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){


                              return  Card(
                                elevation: 5.0,
                                child: Container(
                                  height: 100,
                                  child: Center(
                                    child: ListTile(

                                      onTap: (){


                                      },

                                      leading: CircleAvatar(
                                        child: Center(
                                          child: Text(
                                              (index+1).toString()
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(

                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EventServiceDetails(

                                            id: snapshot.data!.docs[index]['id'],
                                            title: snapshot.data!.docs[index]['title'],
                                            description: snapshot.data!.docs[index]['description'],
                                            eventmanagerid: snapshot.data!.docs[index]['eventmanagerid'],




                                          )));
                                        },

                                        icon: Icon(Icons.arrow_forward_ios),
                                      ),
                                      title: AppText(text: snapshot.data!.docs[index]['title'],size: 18,),
                                      subtitle: AppText(text:  snapshot.data!.docs[index]['description'],size: 16,),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }

                      if(snapshot.hasData && snapshot.data!.docs.length==0){

                        return Center(
                          child: Text("No Data"),
                        );
                      }

                      return Center(child: CircularProgressIndicator());
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
  _imagefromgallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _imagefromcamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
  }

  showimage() {
    showModalBottomSheet(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
