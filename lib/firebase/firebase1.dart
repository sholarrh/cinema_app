

import 'package:cinema_app/provider2.dart';
import 'package:cinema_app/widgets/movie_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class firebase1 extends StatefulWidget {
   firebase1({Key? key}) : super(key: key);

  @override
  State<firebase1> createState() => _firebase1State();
}

class _firebase1State extends State<firebase1> {


  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Provider2>(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: data.movie.snapshots().asBroadcastStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
              if (!streamsnapshot.hasData && streamsnapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              }
              else {
                final datavalue = streamsnapshot.data!.docs.toList();
                print('the data is  ${datavalue.length}');

                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(2),
                  itemCount: datavalue.length,
                  itemBuilder: (BuildContext context, int index) {
                    return movieItem(
                       imageUrl: datavalue[index]['urlDownload'],
                       title: datavalue[index]['movie-title'],
                       description: datavalue[index]['movie-description'],
                        );
                  },
                  separatorBuilder:
                      (BuildContext context, int index) => const Divider(),
                );
              }
            }
        ),
      ],
    );
  }
}
