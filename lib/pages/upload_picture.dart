import 'package:cinema_app/pages/upload_video_page.dart';
import 'package:cinema_app/provider.dart';
import 'package:cinema_app/utils/app_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../firebase/firebase_api.dart';
import '../widgets/button_widget.dart';
import '../widgets/my_text.dart';


class upLoadImage extends StatefulWidget {
  const upLoadImage({Key? key}) : super(key: key);

  @override
  State<upLoadImage> createState() => _upLoadImageState();
}

class _upLoadImageState extends State<upLoadImage> {



  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Counterfile>(context);
    final fileName = data.file != null ? basename(data.file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        automaticallyImplyLeading: false,
        title: Text('Add New Picture',
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

                  SizedBox(height: 20,),
                  MyButton(
                    color: white,
                    child: MyText ('Select File'),
                    // icon: Icons.attach_file,
                    onTap: data.selectFile,
                  ),

                  SizedBox(height: 8),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                  SizedBox(height: 10),

                  MyButton(
                    color: white,
                      child: MyText (
                        'Upload File',),
                    //icon: Icons.cloud_upload_outlined,
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

                      if (data.imageUrl != null)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => upLoadVideo()));
                    }
                  ),

                  SizedBox(height: 20),
                  data.task != null ? buildUploadStatus(data.task!) : Container(
                    color: Colors.white,
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }



  // Future uploadFile() async {
  //   if (file == null) return;
  //
  //   final fileName = basename(file!.path);
  //   final destination = 'files/$fileName';
  //
  //   task = FirebaseApi.uploadFile(destination, file!);
  //   setState(() {});
  //
  //   if (task == null) return;
  //
  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   print('Download-Link: $urlDownload');
  //
  // }

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
                color: Colors.green,),
            );
          } else {
            return Container();
          }
        },
      );
}
