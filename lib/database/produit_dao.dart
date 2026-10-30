import 'package:sqflite/sqflite.dart';
import '../models/produit.dart';
import 'database_helper.dart';

class ProduitDao {
  Future<int> insert(Produit produit) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert(
      'produits',
      produit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<Produit>> getAll() async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query('produits', orderBy: 'nom ASC');

    return maps.map((map) => Produit.fromMap(map)).toList();
  }

  Future<Produit?> getById(int id) async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query(
      'produits',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Produit.fromMap(maps.first);
  }

  Future<int> update(Produit produit) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      'produits',
      produit.toMap(),
      where: 'id = ?',
      whereArgs: [produit.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      'produits',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Produit>> getByCategorie(int categorieId) async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query(
      'produits',
      where: 'categorie_id = ?',
      whereArgs: [categorieId],
      orderBy: 'nom ASC',
    );

    return maps.map((map) => Produit.fromMap(map)).toList();
  }
}