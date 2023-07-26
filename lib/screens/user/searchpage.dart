import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/detailscreen.dart';
import 'package:venue/utilities/apptext.dart';

class SearchPage extends StatefulWidget {
  String? customerid;
  String? cutomername;
  String? customerPhone;
   SearchPage({Key? key,this.customerid,this.customerPhone,this.cutomername}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController keywordController = TextEditingController();
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: btnColor,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              AppText(text: "Search",size: 26,fw: FontWeight.w700,color: Colors.white,),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       flex: 1,
              //       child: RadioListTile(
              //         title: Text('Spaces'),
              //         value: "Auditorium",
              //         groupValue: _selectedValue,
              //         onChanged: (value) {
              //           setState(() {
              //             _selectedValue = value as String;
              //           });
              //         },
              //       ),
              //     ),
              //     Expanded(
              //       child: RadioListTile(
              //         title: Text('Events'),
              //         value: "Event Decoration",
              //         groupValue: _selectedValue,
              //         onChanged: (value) {
              //           setState(() {
              //             _selectedValue = value as String;
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // RadioListTile(
              //   title: Text('Photographers'),
              //   value: "Photographers",
              //   groupValue: _selectedValue,
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedValue = value as String;
              //     });
              //   },
              // ),

              Container(
                margin: EdgeInsets.all(20),
                height: 45,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: keywordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.search),
                    )
                  ],
                ),
              ),

              Container(
                height: size.height * 0.85,
                child: StreamBuilder<QuerySnapshot>(
                  stream:

                      // _selectedValue=="Photographers"?
                      //
                      // FirebaseFirestore.instance.collection('eventservice').where('title',isEqualTo: keywordController.text).snapshots():
                      // _selectedValue=="Event Decoration"?
                      //   FirebaseFirestore.instance.collection('eventservice').where('title',isEqualTo:keywordController.text).snapshots():
                      FirebaseFirestore.instance
                          .collection('user')
                          .where('usertype', isEqualTo: "auditorium")
                          .where('audname', isEqualTo: keywordController.text)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: (){ Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(
                                            id:snapshot.data!
                                                .docs[index]['id'],
                                            customerid: widget.customerid,
                                            customerPhone: widget.customerPhone,
                                            cutomername: widget.cutomername,
                                            img: snapshot.data!
                                                .docs[index]['img'],
                                            name: snapshot
                                                .data!.docs[index]
                                            ['audname'],
                                            phone: snapshot
                                                .data!.docs[index]
                                            ['phoneno'],
                                            email: snapshot.data!
                                                .docs[index]['email'],
                                            facility: snapshot
                                                .data!.docs[index]
                                            ['facilities'],
                                          )));


                              },
                              title:
                                  Text(snapshot.data!.docs[index]['audname']),
                            );
                          });
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
