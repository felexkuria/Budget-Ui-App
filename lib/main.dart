import 'package:budget_ui_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.green[400]),
    home: HomeScreen(),
  ));
}
