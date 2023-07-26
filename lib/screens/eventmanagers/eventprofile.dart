import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class EventProfile extends StatefulWidget {
  String?from;
  var id;
  var imgurl;
  var eventname;

  var pin;
  var place;
  var phoneno;
  var email;

  EventProfile(
      {Key? key,
        this.imgurl,
        this.email,
        this.from,
        this.eventname,
        this.phoneno,
        this.pin,
        this.place,
        this.id})
      : super(key: key);

  @override
  State<EventProfile> createState() => _EventProfileState();
}

class _EventProfileState extends State<EventProfile> {
  TextEditingController eventnameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?
  var imageurl;

  initState() {
    eventnameController.text = widget.eventname;
    placeController.text = widget.place;
    pinController.text = widget.pin;
    phonenoController.text = widget.phoneno;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
          backgroundColor: btnColor,
          title: Text(
            "Edit /Update Profile",
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                AppText(
                  text: "Add Images:",
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      showimage();
                    },
                    child: Container(
                      height: 250,
                      width: 250,
                      color: Colors.transparent,
                      child: _image != null
                          ? ClipRRect(
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ))
                          : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 100.0,
                              backgroundImage: NetworkImage(
                                  widget.imgurl.toString()),
                              backgroundColor: Colors.transparent,
                            ),
                            Icon(
                              Icons.upload_file,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Enter a valid Event name";
                    }
                  },
                  controller: eventnameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: btnColor, width: 2)),
                      hintText: "Event Name",
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return "Enter a valid Phone";
                    }
                  },
                  controller: phonenoController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: btnColor, width: 2)),
                      hintText: "Phone no",
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Enter a valid place";
                    }
                  },
                  controller: placeController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: btnColor, width: 2)),
                      hintText: "place",
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 5) {
                      return "Enter a valid pin";
                    }
                  },
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: btnColor, width: 2)),
                      hintText: "PIN",
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        String fileName = DateTime.now().toString();
                        var ref = FirebaseStorage.instance
                            .ref()
                            .child("profile/$fileName");
                        UploadTask uploadTask =
                        ref.putFile(File(_image!.path));

                        uploadTask.then((res) async {
                          imageurl = (await ref.getDownloadURL()).toString();
                        }).then((value) {
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(widget.id)
                              .update({
                            'eventname': eventnameController.text,
                            'img': imageurl,
                            'place': placeController.text,
                            'pin': pinController.text,
                            'phoneno': phonenoController.text,
                          }).then((value) async {
                            SharedPreferences pref =
                            await SharedPreferences.getInstance();

                            setState((){

                              pref.setString('img', imageurl);

                              var imgurl = pref.getString('img');

                            });


                            Navigator.pop(context);
                          });
                        });
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 200,
                      decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: AppText(
                          text: "Edit profile",
                          size: 24,
                          color: Colors.black,
                          fw: FontWeight.w700,
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
