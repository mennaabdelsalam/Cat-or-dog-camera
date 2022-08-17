import 'package:flutter/material.dart';
import 'package:cat_or_dog/splaashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAT VS DOG',
      home:Myspalsh(),
      debugShowCheckedModeBanner: false,
    );
  }
}
