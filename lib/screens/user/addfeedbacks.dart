import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



import 'package:uuid/uuid.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';



class AddFeedBack extends StatefulWidget {
  String?id;
  String?name;
  String?phone;
   AddFeedBack({Key? key,this.id,this.phone,this.name}) : super(key: key);

  @override
  State<AddFeedBack> createState() => _AddFeedBackState();
}

class _AddFeedBackState extends State<AddFeedBack> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final notifkey = GlobalKey<FormState>();

// daclare these variables inthe extendedstate class

  var uuid = Uuid();
  var _notid;
  List<String>category=["Store","Common"];
  String?_selectedCategory;
  String ?_store;
  String?_storename;
  String?_storeEmail;
  String?storePhone;
  String? id, email, name, phone;

  @override
  initState() {
    _notid = uuid.v1();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,

        elevation: 0.0,
        title: Text(""
            "Create Feedback"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: notifkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Create New Feedback",
                  size: 22,
                  color: Colors.black87,
                  fw: FontWeight.w500,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Title";
                    }
                  },

                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.black),

                      hintText: "Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Description";
                    }
                  },

                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.black),

                      hintText: "Message"),
                ),
                SizedBox(
                  height: 20,
                ),



                // Container(
                //
                //   child: StreamBuilder<QuerySnapshot>(
                //     stream: FirebaseFirestore.instance
                //         .collection('shop')
                //
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return SizedBox.shrink();
                //       }
                //
                //       if (snapshot.hasData &&
                //           snapshot.data!.docs.length == 0) {
                //         return SizedBox.shrink();
                //       }
                //       if(snapshot.hasData && snapshot.data!.docs.length!=0){
                //         return Column(
                //           children: [
                //             DropdownButtonFormField<String>(
                //                 value: _store,
                //                 icon: Icon(
                //                   Icons.arrow_drop_down,
                //                   color: Colors.black,
                //                 ),
                //                 decoration: InputDecoration(
                //                     errorStyle: TextStyle(color: Colors.black),
                //
                //                     hintText: "Select Store"),
                //                 onChanged: (value) => setState(() {
                //                   _store = value;
                //                   print(_store.toString());
                //                 }),
                //                 validator: (value) => value == null
                //                     ? 'field required'
                //                     : null,
                //                 items: snapshot.data!.docs
                //                     .map((DocumentSnapshot document) {
                //
                //                   _storename=document['name'];
                //                   _storeEmail=document['email'];
                //
                //                   return DropdownMenuItem<String>(
                //
                //
                //                       value: document['uid'],
                //                       child: Text(
                //                           '${document['name']}'));
                //                 }).toList()),
                //           ],
                //         );
                //       }
                //
                //       return SizedBox.shrink();
                //     },
                //   ),
                // ),

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (notifkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('feedbacks')
                            .doc(_notid)
                            .set({
                          'fdid': _notid,
                          'title': titleController.text,
                          'description': descriptionController.text,

                          'status': 1,

                           'category':"app",

                          'postedby':widget.name,
                          'userphone':widget.phone,
                          'userid':widget.id,
                          'createdAt': DateTime.now(),
                          'reply':"",
                          'replystatus':0
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                   child: Container(
                     height: 45,
                     width: 150,
                     decoration: BoxDecoration(
                       color: btnColor,
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: Center(
                       child: AppText(
                         text: "Submit",size: 24,fw: FontWeight.w600,

                       ),
                     ),
                   ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// add these function at the bottom of the extended class




}
