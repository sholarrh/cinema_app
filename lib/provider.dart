import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Counterfile extends ChangeNotifier{
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference _movie =
  FirebaseFirestore.instance.collection('Users');
  CollectionReference get movie => _movie;

  UploadTask? task;
  File? file;
  String? urlDownload;
  var imageUrl;
  bool isLoading = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    isLoading = true;
    final path = result.files.single.path!;
    file = File(path);
    notifyListeners();
  }
}