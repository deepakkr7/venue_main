import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:uuid/uuid.dart';
import 'package:venue/admin/viewallfeedbacks.dart';
import 'package:venue/admin/viewallnotificationadmin.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';



class ManageNotifications extends StatefulWidget {
  const ManageNotifications({Key? key}) : super(key: key);

  @override
  State<ManageNotifications> createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final notifkey = GlobalKey<FormState>();

// daclare these variables inthe extendedstate class

  var uuid = Uuid();
  var _notid;
  List<String>category=["Auditorium","Common","EventManagers"];
  String?_selectedCategory;

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
            "Create Notification"),
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
                  text: "Create New Notification",
                  size: 18,
                  color: Colors.black87,
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
                      errorStyle: TextStyle(color: backColor),

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
                      errorStyle: TextStyle(color: backColor),

                      hintText: "Description"),
                ),
                DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.black87),
                  //dropdownColor: primaryColor,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: backColor),

                      hintText: "Select Category"),
                  items: category.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedCategory = newValue;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (notifkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('notification')
                            .doc(_notid)
                            .set({
                          'notid': _notid,
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'category':_selectedCategory,
                          'status': 1,
                          'createdAt': DateTime.now(),
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: btnColor,
                      ),

                      height: 45,
                      width: 120,
                      child: Center(
                        child: AppText(text: "Add",),
                      )
                    ),

                  ),
                ),
                SizedBox(height: 20,),

                Center(
                  child: InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotificationsAdmin()));
                    },
                    child: Container(
                      color: Colors.red,
                      child: Text("View All Notification"),

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
