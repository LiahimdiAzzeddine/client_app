import 'package:client_app/Kmeans.dart';
import 'package:client_app/dataget.dart';
import 'package:client_app/Login.dart';
import 'package:flutter/material.dart';

Future  main() async{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Anti Covid Projet',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginApp(),
    );
  }
}