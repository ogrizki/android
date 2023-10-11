import 'dart:async';

import 'package:flutter/material.dart';
import 'dbmusic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'checkInternet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;

  _HomePageState() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
      seeMusic();
    });
  }

  void truncateData() {
    truncateMusic();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void seeMusic() {
    final isOnline =
        Provider.of<ConnectivityProvider>(context, listen: false).isOnline;
    var resWeb = Uri.parse('https://media.itmo.ru/api_get_current_song.php');

    http.post(resWeb,
        body: {"login": "4707login", "password": "4707pass"}).then((response) {
      String result = jsonDecode(response.body)["info"];

      if (isOnline) {
        List<String> valsMusic = result.split(" - ");
        insertMusic(Music(
          singer: valsMusic[0],
          name: valsMusic[1],
          time_: DateTime.now().toString(),
        ));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Дулин Иванин"),
      ),
      body: Column(
        children: [
          const Text("Лабораторная работа"),
          TextButton(
              onPressed: truncateData, child: const Text("Очистить всЁ")),
          const Divider(),
          FutureBuilder(
              future: selectMusicAll(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Пока музыки нет :("),
                    );
                  }
                  return dataBody(snapshot.data);
                }

                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}

DataTable dataBody(List<Music>? listMusic) {
  return DataTable(
    showCheckboxColumn: false,
    columnSpacing: 10,
    columns: const [
      DataColumn(label: Text("ID")),
      DataColumn(label: Text("Певец")),
      DataColumn(label: Text("Название")),
      DataColumn(label: Text("Время чтения"))
    ],
    rows: listMusic!
        .map((music) =>
            DataRow(onSelectChanged: (value) => print(value), cells: [
              DataCell(Text(music.id.toString())),
              DataCell(Text(music.singer)),
              DataCell(Text(music.name)),
              DataCell(Text(music.time_))
            ]))
        .toList(),
  );
}
