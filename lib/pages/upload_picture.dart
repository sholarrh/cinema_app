
import 'package:cinema_app/provider.dart';
import 'package:cinema_app/utils/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../firebase/firebase_api.dart';
import '../widgets/button_widget.dart';
import '../widgets/my_text.dart';
import '../widgets/reusuable_text_form_field.dart';


class upLoadImage extends StatefulWidget {
  const upLoadImage({Key? key}) : super(key: key);

  @override
  State<upLoadImage> createState() => _upLoadImageState();
}

class _upLoadImageState extends State<upLoadImage> {

  bool isLoading = false;
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Counterfile>(context);
    final fileName = data.file != null ? basename(data.file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBlue,
        automaticallyImplyLeading: false,
        title: Text('Add New Video',
          style: TextStyle(
            color: mainred,
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

                  SizedBox(height: 20,),
                  MyButton(
                    height: 40,
                    icon: Icons.attach_file,
                    color: mainred,
                    child: MyText ('Select File',
                    color: white,),
                    onTap: data.selectFile,
                  ),

                  SizedBox(height: 8),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mainBlue),
                  ),
                  SizedBox(height: 40),
                  data.task != null ? buildUploadStatus(data.task!) : Container(
                    color: white,
                  ),
                  SizedBox(height: 40),

                  InputField(
                    inputController: _titleTextController,
                    isPassword: false,
                    hintText: 'Movie Description',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.person_outline),
                  ),

                  SizedBox(height: 40,),

                  InputField(
                    inputController: _descriptionTextController,
                    isPassword: false,
                    hintText: 'Movie Description',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                    prefixIcon: Icon(Icons.person_outline),
                  ),

                  SizedBox(height: 150,),

                  MyButton(
                    color: mainred,
                      height: 50,
                      child: MyText (
                        'Upload File',),
                    icon: Icons.cloud_upload_outlined,
                    onTap: () async {
                      if (data.file == null) return;

                      final fileName = basename(data.file!.path);
                      final destination = 'files/$fileName';

                      data.task = FirebaseApi.uploadFile(destination, data.file!);
                      setState(() {});

                      if (data.task == null) return;

                      final snapshot = await data.task!.whenComplete(() {});
                      data.imageUrl = await snapshot.ref.getDownloadURL();

                      print('Download-Link: ${data.imageUrl}');

                      if (data.imageUrl != null) {
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
                      }
                    }
                  ),


                ],
              ),
            )
        ),
      ),
    );
  }

  Widget buildUploadStatus(UploadTask task) =>
      StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: mainBlue,),
            );
          } else {
            return Container();
          }
        },
      );
}
