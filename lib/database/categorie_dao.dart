import 'package:sqflite/sqflite.dart';
import '../models/categorie.dart';
import 'database_helper.dart';

class CategorieDao {
  Future<int> insert(Categorie categorie) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert(
      'categories',
      categorie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<Categorie>> getAll() async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query('categories', orderBy: 'nom ASC');

    return maps.map((map) => Categorie.fromMap(map)).toList();
  }

  Future<Categorie?> getById(int id) async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Categorie.fromMap(maps.first);
  }

  Future<int> update(Categorie categorie) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      'categories',
      categorie.toMap(),
      where: 'id = ?',
      whereArgs: [categorie.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}