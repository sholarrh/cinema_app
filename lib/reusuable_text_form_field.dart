import 'package:flutter/material.dart';

TextFormField reusuableTextField (String text, IconData icon,
    bool isPasswordType, TextEditingController controller, validator ) {
  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9),),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black,),
      labelText: text,

      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.9),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,),),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}


TextFormField reusuableTextField2(String text, IconData icon,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9),),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black,),
      labelText: text,
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,),),
    ),
  );
}



