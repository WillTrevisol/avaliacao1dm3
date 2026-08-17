import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  
  static const String gameTable = 'games';
  static const String idColumn = 'id';
  static const String titleColumn = 'title';
  static const String platformColumn = 'platform';
  static const String completedColumn = 'completed'; 

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/local_datasource.db';
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        database.execute(
          '''CREATE TABLE $gameTable(
            $idColumn TEXT PRIMARY KEY,
            $titleColumn TEXT,
            $platformColumn TEXT,
            $completedColumn INTEGER)
          '''
        );
      }
    );
    return database;
  }

}