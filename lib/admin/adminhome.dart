import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venue/admin/AllEventManagers.dart';
import 'package:venue/admin/manageauditoriums.dart';
import 'package:venue/admin/managenotifications.dart';
import 'package:venue/admin/manageservices.dart';
import 'package:venue/admin/viewallauditorium.dart';
import 'package:venue/admin/viewallfeedbacks.dart';
import 'package:venue/admin/viewallpayments.dart';
import 'package:venue/admin/viewallusers.dart';
import 'package:venue/common/loginpage.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/commonfeedbackadmin.dart';
import 'package:venue/utilities/apptext.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        child: ListView(
          children: [


            DrawerHeader(
              decoration: BoxDecoration(
                  color: backColor
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                //   Row(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: btnColor,
                //         radius: 35,
                //
                //         child: Center(
                //           child: Text(widget.fname[0],style: TextStyle(color: Colors.white,fontSize: 22),),
                //         ),
                //       ),
                //       SizedBox(width: 20,),
                //       Text(widget.fname,style: TextStyle(color: Colors.white))
                //     ],
                //   )
                // ],
              ),
            ),

          ],
        ),
      ),

      //backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: btnColor,
        actions: [
          IconButton(onPressed:(){
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
            });
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AppText(text: "Admin Dashboard",size: 26,),
             SizedBox(height: 20,),
             Container(


               height: 100,
               child:
               Row(
                 children: [

  
                   Expanded(
                     child: InkWell(
                       onTap: (){


                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllEventManagers()));
                       },
                       child: Container(
                         height: 100,
                         width: 150,
                         decoration: BoxDecoration(
                         color: backColor,
                           borderRadius: BorderRadius.circular(12),

                         ),

                         child: Center(child: AppText(text: "View All Event\nManagers",color: Colors.white,size: 18,)),
                       ),
                     ),
                   ),

                   SizedBox(width: 20,),

                   Expanded(
                     child: InkWell(


                       onTap: (){


                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllAuditorium()));
                       },

                       child: Container(
                         height: 100,
                         width: 150,
                         decoration: BoxDecoration(
                           color: backColor,
                           borderRadius: BorderRadius.circular(12),

                         ),
                         child: Center(child: AppText(text: "View All\nAuditoriums",color: Colors.white,size: 18,)),

                       ),
                     ),
                   ),

                 ],
               ),
             ),
            SizedBox(height: 10,),
             Container(


               height: 100,
               child:
               Row(
                 children: [


                   Expanded(
                     child: InkWell(

                       onTap: (){


                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllUsers()));
                       },

                       child: Container(
                         height: 100,
                         width: 150,
                         decoration: BoxDecoration(
                           color: backColor,
                           borderRadius: BorderRadius.circular(12),

                         ),
                         child: Center(child: AppText(text: "View All Users",color: Colors.white,size: 18,)),
                       ),
                     ),
                   ),

                   SizedBox(width: 20,),

                   Expanded(
                     child: InkWell(

                       onTap: (){


                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllPayments()));
                       },

                       child: Container(
                         height: 100,
                         width: 150,
                         decoration: BoxDecoration(
                           color: backColor,
                           borderRadius: BorderRadius.circular(12),

                         ),
                         child: Center(child: AppText(text: "View All Payments",color: Colors.white,size: 18,)),

                       ),
                     ),
                   ),

                 ],
               ),
             ),

            SizedBox(height: 10,),
            Container(


              height: 100,
              child:
              Row(
                children: [


                  Expanded(
                    child: InkWell(

                      onTap: (){


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllCommonFeedbackAdmin()));
                      },

                      child: Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          color: backColor,
                          borderRadius: BorderRadius.circular(12),

                        ),
                        child: Center(child: AppText(text: "View All\nFeedbacks",color: Colors.white,size: 18,)),
                      ),
                    ),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: InkWell(

                      onTap: (){


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageNotifications()));
                      },

                      child: Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          color: backColor,
                          borderRadius: BorderRadius.circular(12),

                        ),
                        child: Center(child: AppText(text: "Manage\n Notifications",color: Colors.white,size: 18,)),

                      ),
                    ),
                  ),

                ],
              ),
            ),

           // SizedBox(height: 10,),
            //Container(


            //  height: 100,
           //   child:
              //Row(
                //children: [


          //
                //      ),
                //    ),
                //  ),

                //  SizedBox(width: 20,),

               //   Expanded(
                    //child: InkWell(

                      //onTap: (){


                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageAuditoriums()));
                     // },

                     // child: Container(
                       // height: 100,
                       // width: 150,
                     //   decoration: BoxDecoration(
                          //color: backColor,
                        //  borderRadius: BorderRadius.circular(12),

                      //  ),
                    //    child: Center(child: AppText(text: "Manage\nAuditoriums",color: Colors.white,size: 18,)),

                  //    ),
                //    ),
              //    ),

             //   ],
            //  ),
          //  )




          ],
        ),
      ),
    );
  }
}
