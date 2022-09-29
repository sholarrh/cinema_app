import 'package:cinema_app/pages/auth/signup_page.dart';
import 'package:cinema_app/widgets/button_widget.dart';
import 'package:cinema_app/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../utils/app_color.dart';
import '../../widgets/reusuable_text_form_field.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool isLoading = false;

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'E-mail address is required.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

    return null;
  }
  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return 'Password is required.';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body:  SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18,),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child:
                  Image(image: AssetImage('assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
                ),



                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MyText('Log In',
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                  ),
                ),

                Form(
                  key: _formkey,

                  child: Column(
                    children: [
                      SizedBox(height: 40,),

                      InputField(
                          inputController: _emailTextController,
                          isPassword: false,
                          hintText: 'Email Address',
                          hasSuffixIcon: false,
                          keyBoardType: TextInputType.emailAddress,
                       prefixIcon: Icon(Icons.person_outline),
                      validator: validateEmail,),

                      SizedBox(height: 40,),

                      InputField(
                        inputController: _passwordTextController,
                        isPassword: true,
                        hintText: 'Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: Icon(Icons.lock_outlined),
                        validator: validatePassword,),

                      SizedBox(height: 150,),

                       MyButton(
                        height: 50,
                        color: mainred,
                          onTap: () async {
                            if (_formkey.currentState!.validate())
                            {isLoading = true;
                            setState(() {});
                            try {
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text).then((value)
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => HomePage()));
                                print('signed in');
                              }).onError((error, stackTrace) {
                                print('error ${error.toString()}');
                              });
                            }catch(e,s){
                              print(e);
                              print(s);
                            }
                            Future.delayed(Duration(seconds: 5)).then((value){
                              isLoading = false;
                              setState(() {
                              });});
                            }
                          },
                          child: isLoading == false ? MyText(
                            'Log In',
                            color: white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,)
                          : Center(
                            child: CircularProgressIndicator(
                              color: mainBlue,
                    ),
                ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText('Don\'t have an Account ? ',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: white),

                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },

                        child: MyText('Sign Up',
                            color: mainBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}