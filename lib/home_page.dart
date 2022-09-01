import 'package:cinema_app/upload_video_page.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'login_page.dart';



class HomePage extends StatefulWidget   {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {

  // late final Future<ListResult> futureFiles;
  //
  // @override
  // void initstate(){
  //   super.initState();
  //
  //   futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  // }
  
  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference _reference =
  FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          'assets/images/OOPL-Cinemas-logo-white-website-logo-web.png')),
                ),
                SizedBox(
                  width: 25,),
              ],
            ),
            Row(
              children: [
                InkWell(
                  child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.account_circle,
                                color: Colors.black,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('User')
                              ],
                            )),
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => upLoadVideo()));
                                },
                                child: Text('Add New Movie'))),
                        PopupMenuItem(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black26;
                                }
                                return Colors.white;
                              }),
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                'Logout',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              });
                            },
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _reference.snapshots().asBroadcastStream(),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                    if (!streamsnapshot.hasData && streamsnapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
                      final datavalue = streamsnapshot.data!.docs.toList();
                      print(datavalue.length);
                      print(datavalue[0].data());

                      return ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(2),
                        itemCount: datavalue.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {},
                                  icon: Icons.menu,
                                  backgroundColor: Colors.blueAccent,
                                ),
                                SlidableAction(
                                  onPressed: (_) {},
                                  icon: Icons.delete_outline,
                                  backgroundColor: Colors.red,
                                )
                              ],
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      child: Image(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              '${preview}')),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(datavalue[index]['movie-title'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w400,
                                      ),
                                      ),
                                      SizedBox(
                                        height: 5,),

                                       Text(datavalue[index]['movie-description'],
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w400,),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) => const Divider(),
                      );
                    }
                  }
              ),
              // FutureBuilder<ListResult>
              //   (future: futureFiles,
              //     builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //
              //       final files = snapshot.data!.items;
              //       return Container(
              //       );
              //     } else if (snapshot.hasError) {
              //       return const Center(child: Text('Error Occured'),);
              //     } else {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //     }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> preview = <String>[
  'assets/images/beast.jpg',
  'assets/images/bullet-train.jpg',
  'assets/images/dragonball.jpg',
  'assets/images/hammer.jpg',
  'assets/images/hey-you.jpg',
  'assets/images/obaram.jpg',
  'assets/images/rubicon.jpg',
  'assets/images/setup2.jpg',
  'assets/images/the-invitation.jpg',
  'assets/images/thor.jpg'
];
