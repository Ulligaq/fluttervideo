import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Image.asset('assets/blinkiesCafe-lo.gif'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem(
                title: 'MOVIES',
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              SizedBox(width: 60),
              NavBarItem(
                title: 'CINEPLEX TIMES',
                onTap: () {
                  Navigator.pushNamed(context, '/cineplex');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap; 

  const NavBarItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white, 
        ),
      ),
    );
  }
}