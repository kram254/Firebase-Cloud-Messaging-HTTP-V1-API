import 'package:flutter/material.dart';
import 'package:flutter_notification/home.dart';
import 'package:flutter_notification/other_screen.dart';  // Add other screens as needed

final Map<String, WidgetBuilder> routes = {
  '/': (context) => HomePage(),
  '/home': (context) => HomePage(),
  '/other': (context) => OtherScreen(),  // Example route
  // Add other routes here
};
