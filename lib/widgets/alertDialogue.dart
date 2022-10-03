//
//
// import 'package:cinema_app/utils/app_color.dart';
// import 'package:cinema_app/widgets/my_text.dart';
// import 'package:flutter/material.dart';
//
// class alertDialogue extends StatelessWidget {
//   const alertDialogue({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: MyText(
//         'Delete ?',
//         color: mainred,
//         fontSize: 18,
//       ),
//       content: MyText(
//         'Do you want to delete this movie?',
//         color: white,
//         fontSize: 14,
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed:  (){
//             try async {
//               await data.movie.doc(widget.title)
//                   .delete()
//                   .then((value) {
//               Navigator.of(context).push(
//               MaterialPageRoute(
//               builder: (ctx) => HomePage()));
//               });
//               } catch (e, s) {
//                 print(e);
//                 print(s);
//               }
//               },
//           child: MyText(
//           'Yes',
//           color: mainred,
//           fontSize: 14,
//         ),
//         ),
//       ],
//     );
//   }
// }
