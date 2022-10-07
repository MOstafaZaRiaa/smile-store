import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constance.dart';
import 'package:ecommerce_app/model/order_model.dart';

class AddressDatabaseHelper {
  AddressDatabaseHelper._();

  static final AddressDatabaseHelper db = AddressDatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String? path = join(await getDatabasesPath(), 'AddressDatabase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE $tableAddressDatabase(
      $addressId TEXT NOT NULL,
      $addressName TEXT NOT NULL,
      $street1 TEXT NOT NULL,
      $street2 TEXT NOT NULL,
      $city TEXT NOT NULL,
      $state TEXT NOT NULL,
      $country TEXT NOT NULL)
      ''');
      },
    );
  }

  insert(Address address) async {
    var dbClient = await database;
    await dbClient!.insert(
      tableAddressDatabase,
      address.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Address>> getAllAddress() async {
    var dbClient = await database;
    List<Map> maps = await dbClient!.query(tableAddressDatabase);
    List<Address> list = maps.isEmpty
        ? []
        : maps.map((address) => Address.fromJson(address)).toList();
    return list;
  }
  
  deleteAddress(Address address) async {
    var dbClient = await database;
    dbClient!.delete(tableAddressDatabase,
        where: '$addressId = ?', whereArgs: [address.addressId]);
  }
}
