
import 'package:flutter/material.dart';
import 'package:poetry/bottomNavigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aimee's App",
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: BottomNavigationWidget(),
    );
  }
}
