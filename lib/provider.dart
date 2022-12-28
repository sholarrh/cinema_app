import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class CounterFile extends ChangeNotifier{
  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference _movie =
  FirebaseFirestore.instance.collection('Users');

  CollectionReference get movie => _movie;

  UploadTask? task;
  File? file;
  String? urlDownload;
  var imageUrl;
  bool isLoading = false;
  String? fullname;

  // Future<void>sharedPreferences1(String str) async {
  //   final storage = await SharedPreferences.getInstance();
  //   await storage.setString(fullname!, str);
  //   notifyListeners();
  // }
  //
  Future<void>sharedPreferences() async {
    final storage = await SharedPreferences.getInstance();
    fullname = storage.getString('fullname');
    notifyListeners();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    isLoading = true;
    final path = result.files.single.path!;
    file = File(path);
    notifyListeners();
  }
}