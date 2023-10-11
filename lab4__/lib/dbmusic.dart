import 'database.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqlite_api.dart';

class Music {
  int id;
  String singer;
  String name;
  String time_;

  Music(
      {this.id = 0,
      required this.singer,
      required this.name,
      required this.time_});

  Map<String, dynamic> toMap() {
    return {'singer': singer, 'name': name, 'time_': time_};
  }

  @override
  String toString() {
    return 'Music{id: $id, singer: $singer, name: $name, time: $time_}';
  }
}

Future<void> insertMusic(Music music) async {
  var provider = DBProvider();
  final db = await provider.database;
  String name;
  try {
    final List<Map> namelist = await db.rawQuery("""
    select * from music order by id desc limit 1;
  """);
    namelist.forEach((row) => print(row));

    name = namelist[0]["name"];
    print("Уже в базе есть: $name");
  } catch (e) {
    name = "";
  }

  if (name != music.name) {
    db
        .insert(
          'music',
          music.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        )
        .then((value) => print("Добавлена запись сid = $value"));
  }
}

// A method that retrieves all the music rows from the dogs table.
Future<List<Music>> selectMusicAll() async {
  // Get a reference to the database.
  var provider = DBProvider();
  final db = await provider.database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('music');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Music(
      id: maps[i]['id'],
      singer: maps[i]['singer'],
      name: maps[i]['name'],
      time_: maps[i]['time_'],
    );
  });
}

// A method that retrieves all the music rows from the dogs table.
Future truncateMusic() async {
  // Get a reference to the database.
  var provider = DBProvider();
  final db = await provider.database;

  db.delete('music;');
}
