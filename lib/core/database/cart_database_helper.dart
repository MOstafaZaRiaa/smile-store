import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constance.dart';
import 'package:ecommerce_app/model/cart_product_model.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();

  static final CartDatabaseHelper db = CartDatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String? path = join(await getDatabasesPath(), 'CartDatabase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE $tableCartProduct(
      $columnName TEXT NOT NULL,
      $columnImage TEXT NOT NULL,
      $columnPrice TEXT NOT NULL,
      $columnQuantity INTEGER NOT NULL,
      $columnProductId TEXT NOT NULL)
      ''');
      },
    );
  }

  insert(CartProductModel model) async {
    var dbClient = await database;
    await dbClient!.insert(
      tableCartProduct,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartProductModel>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient!.query(tableCartProduct);
    List<CartProductModel> list = maps.isEmpty
        ? []
        : maps.map((product) => CartProductModel.fromJson(product)).toList();
    return list;
  }

  updateProduct(CartProductModel model) async {
    var dbClient = await database;
    dbClient!.update(tableCartProduct, model.toJson(),
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  deleteProduct(CartProductModel model) async {
    var dbClient = await database;
    dbClient!.delete(tableCartProduct,
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  clearCart()async{
    var dbClient = await database;
    dbClient!.delete(tableCartProduct);
  }
}
