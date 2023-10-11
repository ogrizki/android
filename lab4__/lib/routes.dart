import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'HomePage.dart';
import 'checkInternet.dart';
import 'package:provider/provider.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      final isOnline = Provider.of<ConnectivityProvider>(context).isOnline;

      if (!isOnline) {
        Fluttertoast.showToast(msg: "Нет интернета!");
        // return const Internet();
      }

      switch (settings.name) {
        case "/":
          return const HomePage();
      }

      return const HomePage();
    });
  }
}
