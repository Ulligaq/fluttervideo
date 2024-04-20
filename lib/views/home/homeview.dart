import 'package:flutter/material.dart';

import 'navbar.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/matsuvideo.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Column(
          children: <Widget>[
            NavBar(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}