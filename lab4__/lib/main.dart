import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkInternet.dart';
import 'routes.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: CustomRoute.allRoutes,
          initialRoute: "/",
        ));
  }
}
