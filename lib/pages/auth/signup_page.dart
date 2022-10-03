import 'package:cinema_app/utils/app_color.dart';
import 'package:cinema_app/widgets/my_text.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/reusuable_text_form_field.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  String? fullname;

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _fullnameTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Password is required.';
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
    Password must be at least 8 characters,
    include an uppercase letter, number and symbol.
    ''';
    }

    return null;
  }

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'E-mail address is required.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

    return null;
  }

  String? validateFullName(String? formFullName) {
    if (formFullName == null || formFullName.isEmpty) {
      return 'Full Name is required.';
    }

    return null;
  }

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (_confirmPasswordTextController.text != _passwordTextController.text) {
      return 'Passwords do not match.';
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    // var data = Provider.of<Counterfile>(context);
    return Scaffold(
      backgroundColor: backGround,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,
                      color: white,)),
                ),
                SizedBox(height: 70,),
                 Align(
                   alignment: Alignment.topLeft,
                   child: MyText(
                     'Sign Up',
                       textAlign: TextAlign.start,
                       fontWeight: FontWeight.w700,
                       fontSize: 24,
                       color: white,
                   ),
                 ),
                const SizedBox(
                  height: 40,
                ),

                Form(
                  key: _formkey,
                  child: Column(
                    children:  [
                      InputField(
                        inputController: _fullnameTextController,
                        isPassword: false,
                        hintText: 'Enter Full Name',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: validateFullName,
                      ),

                      const SizedBox(
                    height: 40,),

                      InputField(
                        inputController: _emailTextController,
                        isPassword: false,
                        hintText: 'Enter your Email',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: validateEmail,
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      InputField(
                        inputController: _passwordTextController,
                        isPassword: true,
                        hintText: 'Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validatePassword,
                      ),
                      const SizedBox(
                      height: 40,
                      ),

                      InputField(
                        inputController: _confirmPasswordTextController,
                        isPassword: true,
                        hintText: 'Confirm Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validateConfirmPassword,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: MyButton(
                    height: 50,
                      color: mainred,
                    child: isLoading == false ? MyText('Sign Up',
                      color: white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ):  Center(
                      child: CircularProgressIndicator(
                        color: mainBlue,
                      ),
                    ),
                      onTap:  () async {
                        if (_formkey.currentState!.validate()){
                    isLoading = true;
                    setState(() {
                    });
                    final storage = await SharedPreferences.getInstance();
                    await storage.setString('fullname', _fullnameTextController.text);
                    setState(() {
                    });

                    Duration waitTime = Duration(seconds: 2);
                    Future.delayed(waitTime, (){
                      isLoading = false;
                      setState(() {});
                    });
                   try {
                     await FirebaseAuth.instance
                         .createUserWithEmailAndPassword(
                         email: _emailTextController.text,
                         password: _passwordTextController.text)
                         .then((value) {
                       isLoading = false;
                       setState(() {
                         isLoading = false;
                       });
                       Navigator.pop(context);
                     });
                   }catch (e, s) {
                     print(e);
                     print(s);
                   }
                        }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
