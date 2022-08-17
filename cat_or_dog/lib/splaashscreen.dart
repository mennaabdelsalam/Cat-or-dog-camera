import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' ;
import 'home.dart';

class Myspalsh extends StatefulWidget {
  const Myspalsh({Key? key}) : super(key: key);

  @override
  _MyspalshState createState() => _MyspalshState();
}

class _MyspalshState extends State<Myspalsh> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text(
        'CAT AND DOG',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color(0xffe99600)),
      ),
      image:Image.asset('assets/images/cat.png'),
      photoSize: 50.0,
      backgroundColor: Colors.black,
      loaderColor: Color(0xffeeda28),

    );
  }
}
