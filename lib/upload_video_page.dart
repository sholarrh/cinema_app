
// import 'dart:html' hide File;
import 'dart:math';

import 'package:cinema_app/reusuable_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'package:path/path.dart';
import 'firebase_api.dart';
import 'dart:io';


class upLoadVideo extends StatefulWidget {
  const upLoadVideo({Key? key}) : super(key: key);

  @override
  State<upLoadVideo> createState() => _upLoadVideoState();
}

class _upLoadVideoState extends State<upLoadVideo> {

  UploadTask? task;
  File? file;

  bool isLoading = false;
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        automaticallyImplyLeading: false,
        title: Text('Add New Movie',
          style: TextStyle(
          color: Colors.white,
        ),),
          centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                reusuableTextField2(
                  'Movie Title', Icons.person_outline, _titleTextController,),
                SizedBox(height: 20,),

                reusuableTextField2('Movie Description', Icons.person_outline,
                    _descriptionTextController),
                SizedBox(height: 20,),
                ButtonWidget(
                  text: 'Select File',
                  icon: Icons.attach_file,
                  onClicked: selectFile,
                  isloading: true,
                ),
                SizedBox(height: 8),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                ButtonWidget(
                  text: 'Upload File',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: uploadFile,
                  isloading: true,
                ),
                SizedBox(height: 20),
                task != null ? buildUploadStatus(task!) : Container(color: Colors.white,
                    ),
                SizedBox(height: 100),
                ButtonWidget2(
                    icon: Icons.cloud_upload_outlined,
                    text: 'Upload',
                    isloading: true,
                    onClicked: ()
                    async {
                      try{
                         isLoading = true;
                          setState(() {
                          });
                         await uploadFile;
                        await FirebaseFirestore.instance.collection('Users').add({
                              'movie-title':_titleTextController.text.trim,
                              'movie-description':_descriptionTextController.text.trim,
                            }).then((value)
                            { isLoading = false;
                              setState(() {
                              });
                               Navigator.pop( context);});
                          } catch(_){
                            print('error is $e');
                      }
                      }),
              ],
                    ),
          )
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null) return;

      final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green,),
        );
      } else {
        return Container();
      }
    },
  );

}

// sendUserName() async {
//
//   isLoading = true;
//   setState(() {
//
//   });
//   CollectionReference _collectionRef =
//   FirebaseFirestore.instance.collection
//     ('Users');
//
//   return _collectionRef.add({
//     'Movie Title':_titleTextController.text,
//     'description':_descriptionTextController.text,
//   }).then((value)
//   {
//     isLoading = false;
//     setState(() {
//     });
//      Navigator.pop( context);})
//       .catchError((error)=> print("something is wrong"));
// }