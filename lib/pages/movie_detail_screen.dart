

import 'package:cinema_app/provider2.dart';
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
    var data = Provider.of<Provider2>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: mainBlue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyText(widget.title,
              color: mainred,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),

            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: MyButton(
                          color: mainred,
                          onTap: () async {
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
                          child: Container(
                            width: double.infinity,
                            child: MyText(
                              'Delete',
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

        centerTitle: true,
      ),
      backgroundColor: backGround,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 400,
                width: double.infinity,
                child: Image.network(widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(
                height: 40,
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
                  hintText: widget.description,
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
