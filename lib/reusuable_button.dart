import 'package:flutter/material.dart';

Container signInSignUpButton(
    bool isLogin,bool loading, Function onTap) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: loading ==false ? Text(
          isLogin ? 'Log In' : 'Sign UP',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),) : CircularProgressIndicator(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.red;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))))
    ),
  );
}