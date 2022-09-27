

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
    return ListTile(
      leading: Container(
        width: 100,
        height: 100,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => movieDetailScreen(title, description, imageUrl)));
          },
          child: Image.network(imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: MyText(title,
        fontSize: 18,
        color: Colors.blueAccent,
        fontWeight: FontWeight.w400,
      ),
      subtitle: MyText(getFirstWordsFast(description, " ", 8),
        fontSize: 14,
        color: Colors.blueAccent,
        fontWeight: FontWeight.w400,
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
