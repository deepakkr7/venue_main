import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:venue/constants/colors.dart';
import 'package:venue/screens/user/bottomnavigationpage.dart';
import 'package:venue/utilities/apptext.dart';

class SuccessPage extends StatelessWidget {
  var email;
  var fname;
  var lname;
  var pin;
  var place;
  var id;
  var phone;
  var imgurl;

  SuccessPage(
      {Key? key,
      this.email,
        this.imgurl,
      this.phone,
      this.fname,
      this.lname,
      this.pin,
      this.place,
      this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/successful.json',

              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Success!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Payment Successfull',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationPage(


                  email: email,
                  fname: fname,
                  lname: lname,
                  pin: pin,
                  place: place,
                  id: id,
                  phone: phone,
                  img: imgurl,

                )));
              },
              child: Container(
                height: 45,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: btnColor,

                ),
                child: Center(
                  child: AppText(text: "Back to Home",size: 18,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
