import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/eventmanagers/eventservicedetails.dart';
import 'package:venue/utilities/apptext.dart';

class AddServices extends StatefulWidget {
  var email;
  var eventname;
  var phoneno;
  var pin;
  var place;
  var id;

  AddServices(
      {Key? key,
      this.email,
      this.eventname,
      this.phoneno,
      this.place,
      this.pin,
      this.id})
      : super(key: key);
  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  String? _category;
  List<String> categories = [
    "Photography",
    "Catering Service",
    "Event Decoration"
  ];
  TextEditingController eventserviceController = TextEditingController();
  TextEditingController eventservicedetailsController = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?
  var imageurl;

  var uuid = Uuid();

  var serviceid;
  initState() {
    serviceid = uuid.v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
           backgroundColor: btnColor
       ),
        body: Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    items: categories.map((String category) {
                      return new DropdownMenuItem<String>(
                          value: category,
                          child: Row(
                            children: <Widget>[
                              Text(category),
                            ],
                          ));
                    }).toList(),
                    onChanged: (String? value) {
                      // do other stuff with _category
                      setState(() => _category = value);
                    },
                    value: _category,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 3)),
                        hintText: 'Service ID'),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: eventservicedetailsController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 3)),
                        hintText: 'Service Details'),

                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        showimage();
                      },
                      child: Container(
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
                                      // backgroundImage: NetworkImage(widget.imgurl.toString()),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    Icon(
                                      Icons.upload_file,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      print(_category);

                      String fileName = DateTime.now().toString();
                      var ref = FirebaseStorage.instance
                          .ref()
                          .child("service/$fileName");
                      UploadTask uploadTask = ref.putFile(File(_image!.path));

                      uploadTask.then((res) async {
                        imageurl = (await ref.getDownloadURL()).toString();
                      }).then(
                        (value) {
                          FirebaseFirestore.instance
                              .collection('eventservice')
                              .doc(serviceid)
                              .set({
                            'id': serviceid,
                            'title': _category,
                            'description': eventservicedetailsController.text,
                            'status': 1,
                            'place': widget.place,
                            'phone': widget.phoneno,
                            'pin': widget.pin,
                            'eventmanagerid': widget.id,
                            'eventname': widget.eventname,
                            'imgurl': imageurl
                          }).then((value) {
                            setState(() {
                              serviceid = uuid.v1();
                            });
                          });
                        },
                      ).then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      height: 40,
                      width: 250,
                      color: btnColor,
                      child: Center(
                        child: AppText(
                          text: "Add Service",
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
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
