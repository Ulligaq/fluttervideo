import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/home/homeview.dart';
import 'views/home/aboutpage.dart';
import 'views/home/cineplexpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
    

  ),
);
  runApp(MatSuVideo());
}

class MatSuVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatSuVideo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/about', 
      routes: {
        '/about': (context) => AboutPage(), 
        '/cineplex': (context) => CineplexPage(),

      },
    );
  }
}