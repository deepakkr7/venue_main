import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class AudProfile extends StatefulWidget {
  var email;
  var imgurl;
  var audname;
  var phoneno;
  var pin;
  var place;
  var id;
  var facilities;

  AudProfile(
      {Key? key,
      this.email,
        this.facilities,
        this.imgurl,
      this.audname,
      this.phoneno,
      this.place,
      this.pin,
      this.id})
      : super(key: key);

  @override
  State<AudProfile> createState() => _AudProfileState();
}

class _AudProfileState extends State<AudProfile> {
  TextEditingController audnameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  final key = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?


  bool _checked1 = false;
  bool _checked2 = false;
  bool _checked3 = false;
  bool _checked4 = false;
  bool _checked5 = false;
  bool _checked6 = false;
  List? selectedItemsindex = [];
  List? selectedItems = [];
  List<String> facilities = [
    "wifi",
    "parking",
    "Kids Area",
    "Ac",
    "Prayer Area"
  ];

  var imageurl;

  var facility = [];
  @override
  initState() {
    audnameController.text = widget.audname;
    placeController.text = widget.place;
   // selectedItems!.addAll(widget.facilities);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.facilities);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: btnColor,
          title: Text(
            "Edit /Update Profile",
          )),
      body: Container(
        height: double.infinity,
        color: Colors.white70,
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 30, top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Enter a valid name";
                    }
                  },
                  controller: audnameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: btnColor, width: 1)),
                      hintText: "Auditorium Name",
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Enter a valid  Place";
                    }
                  },
                  controller: placeController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: btnColor, width: 1)),
                      hintText: "Place",
                      hintStyle: TextStyle(color: Colors.black54)),
                ),

                SizedBox(
                  height: 20,
                ),
                AppText(text: "Add Images:",size: 24,),
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
                                    backgroundImage: NetworkImage(widget.imgurl.toString()),
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
                SizedBox(
                  height: 20,
                ),

                AppText(
                  text: "Add Facilities",
                  talign: TextAlign.left,
                  size: 24,
                ),
                SizedBox(
                  height: 20,
                ),


                Container(

                    height: 150,
                    child:
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 5 / 2),
                        itemCount: facilities.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (selectedItemsindex!.contains(index)) {
                                setState(() {
                                  selectedItemsindex!.remove(index);
                                  selectedItems!.remove(facilities[index]);
                                  print(selectedItemsindex);
                                  print(selectedItems);
                                });
                              } else {
                                setState(() {
                                  selectedItemsindex!.add(index);
                                  selectedItems!.add(facilities[index]);
                                  print(selectedItemsindex);
                                  print(selectedItems);
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: !selectedItemsindex!.contains(index)
                                    ? Colors.grey
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),

                              height: 25,
                              width: 100,
                              child: Center(
                                  child: Text(
                                facilities[index],
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                            ),
                          );
                        })),

                Center(
                  child: InkWell(
                    onTap: () {
print("***********************");
print(selectedItems);
                      widget.facilities!=null?selectedItems!.addAll(widget.facilities):null;
                      if (key.currentState!.validate()) {
                       if(_image==null){
                         FirebaseFirestore.instance
                             .collection('user')
                             .doc(widget.id)
                             .update({
                           'audname': audnameController.text,
                           'place': placeController.text,

                           'facilities':selectedItems,
                           'status': 1
                         })
                             .then((value) {
                           Navigator.pop(context);
                         });

                       }
                       else{

                         String fileName = DateTime.now().toString();
                         var ref = FirebaseStorage.instance
                             .ref()
                             .child("aud/$fileName");
                         UploadTask uploadTask = ref.putFile(File(_image!.path));

                         uploadTask.then((res) async {
                           imageurl = (await ref.getDownloadURL()).toString();
                         }).then((value) {
                           FirebaseFirestore.instance
                               .collection('user')
                               .doc(widget.id)
                               .update({
                             'name': audnameController.text,
                             'place': placeController.text,
                             'img': imageurl,
                             'facilities':selectedItems,
                             'status': 1
                           })
                               .then((value) {
                                 Navigator.pop(context);
                           });

                         });
                       }
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: AppText(
                          text: "Update",
                          color: Colors.white,
                          size: 24,
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
