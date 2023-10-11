// ignore: file_names
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  late bool _isOnline = true;

  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    Connectivity connectity = Connectivity();

    connectity.onConnectivityChanged.listen((result) async {
      _isOnline = true;
      var typeConnect = await (connectity.checkConnectivity());
      if (typeConnect == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }
}
