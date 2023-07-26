import 'package:flutter/material.dart';
import 'package:venue/utilities/apptext.dart';


class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return        Container(
      child: Row(
        children: [
          Expanded(
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: 150,
              )),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Venue",
                    size: 40,
                    fw: FontWeight.w900,
                    color: Colors.white,
                  ),
                  AppText(
                    text: "Find Your Space",
                    size: 17,
                    fw: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
