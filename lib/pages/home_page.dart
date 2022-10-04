//import 'package:cinema_app/pages/upload_picture.dart';
import 'package:cinema_app/firebase/firebase1.dart';
import 'package:cinema_app/pages/auth/login_page.dart';
import 'package:cinema_app/pages/upload_picture.dart';
import 'package:cinema_app/utils/app_color.dart';

//import 'package:cinema_app/pages/upload_video_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/button_widget.dart';
import '../widgets/my_text.dart';




class HomePage extends StatefulWidget   {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          'assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
                ),
                SizedBox(
                  width: 25,),
              ],
            ),
            Row(
              children: [
                InkWell(
                  child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.account_circle,
                                color: Colors.black,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('User')
                              ],
                            )),
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => upLoadImage()));
                                },
                                child: const Text('Add New Movie'))),
                        PopupMenuItem(
                          child: MyButton(
                              onTap: () async {
                                try {
                                  await FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (ctx) => LoginPage()));
                                  });
                                  } catch (e, s) {
                                      print(e);
                                      print(s);
                                      }
                              },
                            child: Container(
                            width: double.infinity,
                              child: MyText(
                                'Logout',
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                        ),
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: firebase1(),
        ),
      ),
    );
  }
}
