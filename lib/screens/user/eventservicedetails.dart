import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/utilities/apptext.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ServiceDetailsScreenUser extends StatefulWidget {

  String?title;
  String?id;
  String?eventmanagerid;
  String?eventname;
String?description;
String?customerid;
String?cutomername;
String?customerPhone;
  String?phone;
  String?pin;
  String?location;
  String? imgurl;
  ServiceDetailsScreenUser({Key? key,this.imgurl,this.eventmanagerid,this.eventname,this.customerid,this.customerPhone,this.cutomername,this.pin,this.title,this.id,this.phone,this.location,this.description}) : super(key: key);

  @override
  State<ServiceDetailsScreenUser> createState() => _ServiceDetailsScreenUserState();
}

class _ServiceDetailsScreenUserState extends State<ServiceDetailsScreenUser> {
  String? dateTime;
  String? _setTime, _setDate;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  List<String> timeslots = ["Full day", "half day(Lunch)", "Half day(Dinner)"];
String?time;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dateController2 = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();

  var uuid=Uuid();
  var callbackid;
  var _facilities=[];
  @override
  initState(){

callbackid=uuid.v1();

  }
  @override
  Widget build(BuildContext context) {
    print(widget.imgurl);
    return Scaffold(

      body: Container(

        height: double.infinity,
        width: double.infinity,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Container(
                color: Colors.green,
                height: MediaQuery.of(context).size.height/2,
                child:Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width,


                      child: widget.imgurl ==
                          null
                          ? Image.asset(
                        'assets/images/photography2.jpg',
                        fit: BoxFit.cover,
                      ):
                           Image.network(
                        widget.imgurl.toString(),fit: BoxFit.fitWidth,)
                    ),



                    Positioned(

                      bottom: 30,
                      left: 20,
                      child: Container(
                        child: AppText(text: widget.eventname,color: Colors.white, size: 24,fw: FontWeight.w700,),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      AppText(text: 'Description',size:20 ,fw: FontWeight.w900),
                      SizedBox(height: 20),


                      AppText(text: widget.description,size:20 ,fw: FontWeight.w500),
                      SizedBox(height: 50),

                      AppText(text: "Contact Details",size:20 ,fw: FontWeight.w900,),
                      SizedBox(height: 10),

                      Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 85,
                          child: Row(
                            children: [

                              Expanded(
                                child: Container(

                                  child: Row(
                                    children: [

                                      InkWell(

                                          onTap:(){

                                            UrlLauncher.launch('tel:+${widget.phone.toString()}');
                                          },
                                          child: Icon(Icons.phone,color: Colors.green,)),
                                      SizedBox(width: 10,),
                                      Text(widget.phone.toString())
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),




                      SizedBox(height: 10),



                      SizedBox(height: 10),







                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: (){

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext
                      context) =>
                          AlertDialog(
                            title: const Text(
                                'Request Send'),
                            content:
                            Container(
                              //color: Colors.red,
                              height: MediaQuery.of(
                                  context)
                                  .size
                                  .height /
                                  2,
                              child:
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                      40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <
                                          Widget>[

                                        Expanded(
                                          child:
                                          Container(
                                            width: 120,
                                            child: TextFormField(
                                              style: TextStyle(fontSize: 16),
                                              enabled: false,
                                              keyboardType: TextInputType.text,
                                              controller: _dateController2,
                                              onSaved: (String? val) {
                                                _setDate = val!;
                                              },
                                              decoration: InputDecoration(
                                                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                                  hintText: "Select Date",
                                                  contentPadding: EdgeInsets.only(top: 0.0)),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            var picked = await showDatePicker(context: context, initialDate: selectedDate2, initialDatePickerMode: DatePickerMode.day, firstDate: DateTime(2015), lastDate: DateTime(2101));
                                            if (picked != null)
                                              setState(() {
                                                selectedDate2 = picked;
                                                _dateController2.text = DateFormat.yMd().format(selectedDate2);
                                              });
                                          },

                                          child: Icon(Icons.calendar_month),
                                        )

                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                      20,
                                    ),
                                    DropdownButtonFormField(
                                      items: timeslots.map((String
                                      time) {
                                        return new DropdownMenuItem<String>(
                                            value: time,
                                            child: Row(
                                              children: <Widget>[
                                                Text(time),
                                              ],
                                            ));
                                      }).toList(),
                                      onChanged:
                                          (String?
                                      value) {
                                        // do other stuff with time
                                        setState(() =>
                                        time = value);
                                      },
                                      value:time,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                          OutlineInputBorder(),
                                          focusedBorder:
                                          OutlineInputBorder(borderSide: BorderSide(color: btnColor, width: 3)),
                                          hintText: 'Time Slot'),
                                    ),
                                    SizedBox(
                                      height:
                                      20,
                                    ),
                                    TextFormField(
                                      controller:
                                      commentcontroller,
                                      maxLines:
                                      5,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                          OutlineInputBorder(),
                                          focusedBorder:
                                          OutlineInputBorder(borderSide: BorderSide(color: btnColor, width: 3)),
                                          hintText: "Comments"),
                                    ),
                                    SizedBox(
                                      height:
                                      20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance.collection('servicecallback').doc(callbackid).set({
'eventname':widget.eventname,
                                    'callbackid':callbackid,
                                    'customerphone':widget.phone,
                                    'customerid':widget.customerid,
                                    'customername':widget.cutomername,
                                    'managerid':widget.eventmanagerid,
                                    'status':1,
                                    'callstatus':0,
                                    'session':time,
                                    'servicetype':widget.title,
                                    'comment':commentcontroller.text,
                                    'date':_dateController2.text,
                                    'createdat':DateTime.now()

                                  }).then((value)
                                  {
Navigator.pop(context);
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Request Send'),
                                        content: const Text('Thanks for showing Interest, our customer care executive will call you back soon'),
                                        actions: <Widget>[

                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }



                                  );
                                },
                                child:
                                const Text(
                                    'OK'),
                              ),
                            ],
                          ),
                    );


                  },
                  child: Container(
                    height: 40,
                    width:200,

                    decoration: BoxDecoration(

                        color: btnColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(child: AppText(text: "Request Call Back",size: 20,color: Colors.black,fw: FontWeight.w500,)),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),

    );
  }
}
