// Страничка плохого подключения к интернету

import 'package:flutter/material.dart';

class Internet extends StatelessWidget {
  const Internet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Нет интернета :( )"),
        ),
        body: const Text("Отсуствует подключение к интернету!"));
  }
}
