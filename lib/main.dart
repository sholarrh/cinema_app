
import 'package:cinema_app/pages/onboarding/splashScreen.dart';
import 'package:cinema_app/provider.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counterfile()),
      ],
      child: MaterialApp(
        home: splashScreeen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

