import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/home/homeview.dart';
import 'views/home/aboutpage.dart';
import 'views/home/cineplexpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'AIzaSyAz_MvwmM_DyQyRm5ZtKTBdrA1p_S8qAmA',
    appId: '1:830254770157:web:fb37477a7e3ab70cb3e9e4',
    messagingSenderId: '830254770157',
    projectId: 'matsuvideo-e23d8',

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