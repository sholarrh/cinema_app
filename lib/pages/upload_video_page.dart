
//import 'dart:convert';

import 'package:cinema_app/utils/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:path/path.dart';
//import 'dart:io';
//import '../firebase/firebase_api.dart';
import '../provider.dart';
import '../widgets/button_widget.dart';
import '../widgets/my_text.dart';
import '../widgets/reusuable_text_form_field.dart';


class upLoadVideo extends StatefulWidget {
   upLoadVideo();

   //const upLoadVideo({Key? key}) : super(key: key);

  @override
  State<upLoadVideo> createState() => _upLoadVideoState();
}

class _upLoadVideoState extends State<upLoadVideo> {

  //UploadTask? task;
  //File? file;


  bool isLoading = false;

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  final fileName = file != null ? basename(file!.path) : 'No File Selected';
    var data = Provider.of<Counterfile>(context);

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
                 InputField(
                   inputController: _titleTextController,
                   isPassword: false,
                   hintText: 'Movie Description',
                   hasSuffixIcon: false,
                   keyBoardType: TextInputType.emailAddress,
                   prefixIcon: Icon(Icons.person_outline),
                 ),

                  SizedBox(height: 20,),

                  InputField(
                    inputController: _descriptionTextController,
                    isPassword: false,
                    hintText: 'Movie Description',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                    prefixIcon: Icon(Icons.person_outline),
                  ),

                  SizedBox(height: 20,),
                  // ButtonWidget(
                  //   text: 'Select File',
                  //   icon: Icons.attach_file,
                  //   onClicked: selectFile,
                  //   isloading: true,
                  // ),
                  SizedBox(height: 8),
                  // Text(
                  //   fileName,
                  //   style: TextStyle(fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.green),
                  // ),
                  SizedBox(height: 10),

                  // ButtonWidget(
                  //   text: 'Upload File',
                  //   icon: Icons.cloud_upload_outlined,
                  //   isloading: true,
                  //   onClicked: uploadFile,
                  //
                  // ),

                  SizedBox(height: 20),
                  // task != null ? buildUploadStatus(task!) : Container(
                  //   color: Colors.white,
                  // ),
                  SizedBox(height: 100),


                  MyButton(
                    color: white,
                      child: MyText('Upload'),
                      onTap: () async {
                        try {
                          await FirebaseFirestore.instance.collection('Users')
                              .doc(_titleTextController.text)
                              .set({
                            'movie-title': _titleTextController.text,
                            'movie-description': _descriptionTextController
                                .text,
                             'urlDownload': data.imageUrl,
                          })
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          });
                        } catch (e, s) {
                          print(e);
                          print(s);
                        }
                      }),
                ],
              ),
            )
        ),
      ),
    );
  }

//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result == null) return;
//     isLoading = true;
//     final path = result.files.single.path!;
//
//     setState(() => file = File(path));
//   }
//
//   Future uploadFile() async {
//     if (file == null) return;
//
//     final fileName = basename(file!.path);
//     final destination = 'files/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     print('Download-Link: $urlDownload');
//   }
//
//   Widget buildUploadStatus(UploadTask task) =>
//       StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);
//
//             return Text(
//               '$percentage %',
//               style: TextStyle(fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,),
//             );
//           } else {
//             return Container();
//           }
//         },
//       );
// }
}
