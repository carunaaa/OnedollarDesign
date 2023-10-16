import 'package:flutter/material.dart';
import 'package:imageslider/common_widget/BottomNav.dart';
import 'package:imageslider/common_widget/Image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _selectedIndex = 0;
  final List<Widget> viewContainer = [
    ImagesState(),
    // Add more widgets to viewContainer if needed
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void main() {
  //   runApp(MyApp());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.blueGrey),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.blueGrey,
        // ),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ONLY 1DOLLAR DESIGN",
              style: TextStyle(
                color: Colors.grey[400],
                fontFamily: 'PoppinsLight',
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.deepPurple.shade100,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'ONLY \$1 DESIGN',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'PoppinsLight',
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0),
        child: ListView(
          children: viewContainer,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
