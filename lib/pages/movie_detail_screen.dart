

import 'package:cinema_app/provider.dart';
import 'package:cinema_app/utils/app_color.dart';
import 'package:cinema_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/button_widget.dart';
import 'home_page.dart';


class movieDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

 movieDetailScreen(
     this.title,
     this.description,
     this.imageUrl
     );


  @override
  State<movieDetailScreen> createState() => _movieDetailScreenState();
}

class _movieDetailScreenState extends State<movieDetailScreen> {

  TextEditingController _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Counterfile>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: mainBlue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),

               MyText(widget.title,
                color: mainred,
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),

            InkWell(
              child: PopupMenuButton(
                color: mainBlue,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Expanded(
                      child: AlertDialog(
                          title: MyText(
                            'Delete ?',
                            color: mainred,
                            fontSize: 20,
                          ),
                          content: MyText(
                            'Do you want to delete this movie?',
                            color: white,
                            fontSize: 14,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed:  ()async {
                                try {
                                  await data.movie.doc(widget.title)
                                      .delete()
                                      .then((value) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => HomePage()));
                                  });
                                } catch (e, s) {
                                print(e);
                                print(s);
                                }
                              },
                              child: MyText(
                                'Yes',
                                color: white,
                                fontSize: 14,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child:  MyText(
                                  'No',
                                  color: white,
                                  fontSize: 14,
                                ),
                            )
                          ],
                          backgroundColor: mainBlue,
                        ),
                    ),
                      ),
                      // PopupMenuItem(
                      //     child: MyButton(
                      //       color: mainred,
                      //       onTap: () async {
                      //         try {
                      //           await data.movie.doc(widget.title)
                      //               .delete()
                      //               .then((value) {
                      //             Navigator.of(context).push(
                      //                 MaterialPageRoute(
                      //                     builder: (ctx) => HomePage()));
                      //           });
                      //         } catch (e, s) {
                      //           print(e);
                      //           print(s);
                      //         }
                      //       },
                      //       child: MyText(
                      //         'Delete',
                      //         color: white,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     )
                      // ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: backGround,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(widget.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: MyText(widget.description,
                  fontSize: 22,
                  textAlign: TextAlign.start,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _descriptionTextController,
                autocorrect: true,
                onChanged: (value){},
                showCursor: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Update Movie Description',
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(.75),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20,),

              MyButton(
                height: 50,
                color: mainred,
                onTap: ()async {

                  try {
                    await data.movie.doc(widget.title)
                        .update({
                      'movie-description': _descriptionTextController.text,
                    }).then((value) {
                     // print ('this is ${data.movie.snapshots.id}');
                      Navigator.pop(context);
                    });
                  } catch (e, s) {
                    print(e);
                    print(s);
                  }
                },
                child: MyText(
                  'Update',
                  color: white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
