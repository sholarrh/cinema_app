

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Provider2 extends ChangeNotifier{
  final user = FirebaseAuth.instance.currentUser;


  final CollectionReference _movie =
  FirebaseFirestore.instance.collection('Users');


  CollectionReference get movie => _movie;


}