import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;
  final bool isloading;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
    required this.isloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.9),
        minimumSize: Size.fromHeight(50),
      ),
      child: buildContent(),
      onPressed: onClicked,
    ),
  );

  Widget buildContent() => Container(
    width: double.infinity,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 22,color: Colors.black,),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ],
    ),
  );
}

class ButtonWidget2 extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;
  final bool isloading;

  const ButtonWidget2({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
    required this.isloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.red,
      minimumSize: Size.fromHeight(50),
    ),
    child: buildContent(),
    onPressed: onClicked,
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 22,color: Colors.black,),
      SizedBox(width: 10),
      Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.black),
      ),
    ],
  );
}