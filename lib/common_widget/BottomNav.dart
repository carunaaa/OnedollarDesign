import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:imageslider/pages/AddtoCart.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.deepPurple.shade200,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) => {
          if (index == 2)
            {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage())),
            },
        },
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
             size: 30,
              color: Colors.white,
             ),
          Icon(
            Icons.shopping_bag,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
