import 'package:path/path.dart';
import 'package:pokemon_app/src/core/db/db_client.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDbClientImpl implements DbClient {
  PokemonDbClientImpl();

  static String databaseName = 'pokemon.db';
  static String tableName = 'pokemons';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id_pokemon INTEGER PRIMARY KEY,
            id INTEGER,
            name TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> insert(Map<String, dynamic> data) async {
    final db = await database;
    final item = await getItemFromID(data['id'].toString());
    if (item == null) {
      await db.insert(tableName, data);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> query() async {
    final db = await database;
    return await db.query(tableName, orderBy: 'id');
  }

  @override
  Future<Map<String, dynamic>?> getItemFromID(String id) async {
    final db = await database;
    try {
      final list =
          await db.query(tableName, where: 'id = ?', whereArgs: [id]);
      if (list.isNotEmpty) {
        return list.first;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
