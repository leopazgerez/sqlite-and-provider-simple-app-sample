
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/dog_model.dart';

class DogsDataBase {
  static Database? _dataBase;

  DogsDataBase._init();

  static final DogsDataBase instance = DogsDataBase._init();

  Future<Database?> get database async {
    if (_dataBase != null) {
      return _dataBase!;
    } else {
      _dataBase = await _initDB('dogs.db');
      return _dataBase;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDataBase);

  }



  Future _createDataBase(Database dataBase, int version) async {
    await dataBase.execute(
        'CREATE TABLE Dogs ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name TEXT, '
            'age INTEGER )');
  }

  Future<void> insertDog(DogModel dog) async {
    final dataBase = await instance.database;
    await dataBase!.insert('Dogs', dog.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteDog(int id) async {
    final dataBase = await instance.database;
    return dataBase!.delete('Dogs', where: 'id = ?', whereArgs: [id]);
  }

  Future updateDog(DogModel dog) async {
    final dataBase = await instance.database;
    return dataBase!.update(
        'Dogs', dog.toJson(), where: 'id = ?', whereArgs: [dog.id]);
  }

  Future<List<DogModel>> dogsList() async {
    final dataBase = await instance.database;
    final result = await dataBase!.query('Dogs');
    print(result);
    return result.map((json) => DogModel.fromJson(json)).toList();
    // final List<Map<String, dynamic>> dogsMap = await dataBase!.query('Dogs');
    // return List.generate(dogsMap.length, (item) =>
    //     DogModel(
    //         id: dogsMap[item]['id'],
    //         name: dogsMap[item]['name'],
    //         age: dogsMap[item]['age'])
    // );
  }

Future close() async {
  final dataBase = await instance.database;
  dataBase?.close();
}
}