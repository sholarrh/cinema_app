

import 'package:cinema_app/pages/auth/login_page.dart';
import 'package:cinema_app/utils/app_color.dart';
import 'package:cinema_app/widgets/my_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

class splashScreeen extends StatelessWidget {
  const splashScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            child: Image(
                fit: BoxFit.contain,
                image: AssetImage(
                    'assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
          ),
          Row(
            children: [
              MyText('Help',
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w400,),
              SizedBox(
                width: 20,
              ),
              MyText('Privacy',
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.w400,),
            ],
          )
        ],
      ),
    ),
      backgroundColor: backGround,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroudpicture.PNG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 41, right: 41, top: 400,),
            child: MyButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()),
                );
              },
              child: Container(
                height: 56,
                width: 332,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: MyText(
                    'Welcome',
                    color: mainred,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
