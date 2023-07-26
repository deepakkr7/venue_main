import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';

class AddPackages extends StatefulWidget {
  String?id;
   AddPackages({Key? key,this.id}) : super(key: key);

  @override
  State<AddPackages> createState() => _AddPackagesState();
}

class _AddPackagesState extends State<AddPackages> {

  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController offer=TextEditingController();


  var uuid=Uuid();
  var packageId;

  final key=GlobalKey<FormState>();

  @override
  initState(){

    packageId=uuid.v1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
      ),
     body: Container(
       padding: EdgeInsets.all(20),

       height:double.infinity,
       width:double.infinity,

       child: Form(
         key: key,
         child: Column(
           children: [
             SizedBox(height: 10,),

             TextFormField(
               validator: (value) {
                 if (value!.isEmpty || value.length <= 2) {
                   return "Enter a valid  title";
                 }
               },
               controller: title,
               decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   enabledBorder: OutlineInputBorder(
                       borderSide:
                       BorderSide(color: Colors.black, width: 1)),
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: btnColor, width: 1)),
                   hintText: "Title",
                   hintStyle: TextStyle(color: Colors.black54)),
             ),
             SizedBox(height: 10,),
             TextFormField(
               validator: (value) {
                 if (value!.isEmpty || value.length <= 2) {
                   return "Enter a valid  description";
                 }
               },
               controller: description,
               decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   enabledBorder: OutlineInputBorder(
                       borderSide:
                       BorderSide(color: Colors.black, width: 1)),
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: btnColor, width: 1)),
                   hintText: "Description",
                   hintStyle: TextStyle(color: Colors.black54)),
             ),
             SizedBox(height: 10,),
             TextFormField(
               validator: (value) {
                 if (value!.isEmpty || value.length <= 2) {
                   return "Enter a valid  name";
                 }
               },
               controller: price,
               decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   enabledBorder: OutlineInputBorder(
                       borderSide:
                       BorderSide(color: Colors.black, width: 1)),
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: btnColor, width: 1)),
                   hintText: "Price details",
                   hintStyle: TextStyle(color: Colors.black54)),
             ),
             SizedBox(height: 10,),
             TextFormField(
               validator: (value) {
                 if (value!.isEmpty ) {
                   return "Enter a valid  name";
                 }
               },
               controller: offer,
               decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   enabledBorder: OutlineInputBorder(
                       borderSide:
                       BorderSide(color: Colors.black, width: 1)),
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: btnColor, width: 1)),
                   hintText: "Offer details",
                   hintStyle: TextStyle(color: Colors.black54)),
             ),

             SizedBox(
               height: 30,
             ),

             InkWell(
               onTap: (){


                 if(key.currentState!.validate()){

                   FirebaseFirestore.instance.collection('packages').doc(packageId).set({


                     'packageId':packageId,
                     'uid':widget.id,
                     'title':title.text,
                     'description':description.text,
                     'price':price.text,
                     'offer':offer.text,
                     'status':1,
                     'createdat':DateTime.now()

                   }).then((value) {

                     Navigator.pop(context);
                   });
                 }
               },
               child: Container(
                 height: 45,
                 width: 250,
                 decoration: BoxDecoration(
                     color: btnColor,
                     borderRadius: BorderRadius.circular(15)),
                 child: Center(
                   child: AppText(
                     text: "Add Package",
                     color: Colors.white,
                     size: 20,
                   ),
                 ),
               ),
             )


           ],
         ),
       ),
     ),
    );
  }
}
