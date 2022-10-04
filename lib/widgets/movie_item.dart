

import 'package:cinema_app/pages/movie_detail_screen.dart';
import 'package:cinema_app/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class movieItem extends StatelessWidget {

  final String title;
  final String description;
  final String imageUrl;

  movieItem (
  {required this.title,
      required this.description,
      required this.imageUrl,}
      ){}

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: double.infinity,
            height: 300,

            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => movieDetailScreen(title, description, imageUrl)));
              },
              child: Image.network(imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,

            child:  MyText(title,
              textAlign: TextAlign.center,
              fontSize: 30,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              children: [
                MyText(getFirstWordsFast(description, " ", 4),
                  fontSize: 22,
                  textAlign: TextAlign.start,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w400,
          ),
                MyText(' ...',
                  fontSize: 27,
                  textAlign: TextAlign.start,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w400,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String getFirstWordsFast(String description, String wordSeparator, int findCount) {

  if (findCount < 1) {
    return '';
  }

  Runes spaceRunes = Runes(wordSeparator);
  Runes sentenceRunes = Runes(description);
  String finalString = "";

  for (int letter in sentenceRunes) {
    if (letter == spaceRunes.single) {
      findCount -= 1;
      if (findCount < 1) {
        return finalString;
      }
    }
    finalString += String.fromCharCode(letter);
  }
  return finalString;
}

// ListTile(
// leading: Container(
// width: 100,
// height: 400,
// child: GestureDetector(
// onTap: (){
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (ctx) => movieDetailScreen(title, description, imageUrl)));
// },
// child: Image.network(imageUrl,
// fit: BoxFit.cover,
// ),
// ),
// ),
// title: MyText(title,
// fontSize: 18,
// color: Colors.blueAccent,
// fontWeight: FontWeight.w400,
// ),
// subtitle: MyText(getFirstWordsFast(description, " ", 8),
// fontSize: 14,
// color: Colors.blueAccent,
// fontWeight: FontWeight.w400,
// ),
// );
