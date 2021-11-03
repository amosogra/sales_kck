import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sqflite/sqflite.dart';

class OrderDBHelper{

  Future<Database> initializeTotalDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'kck_sale_database.db'),
      onCreate: (database, version) async {

        await database.execute(
          'CREATE TABLE orders(id INTEGER PRIMARY KEY, companyCode TEXT, custAccNo TEXT, custName TEXT , docNo TEXT '
              + ' , docDate TEXT , invAddr1 TEXT , invAddr2 TEXT , invAddr3 TEXT , invAddr4 TEXT '
              + ' , branchCode TEXT , salesLocation TEXT , shipVia TEXT , shipInfo TEXT , attention TEXT '
              + ' , displayTerm TEXT , salesAgent TEXT , inclusiveTax TEXT , subtotalAmt TEXT , taxAmt TEXT '
              + ' , totalAmt TEXT , remark1 TEXT, remark2 TEXT,  remark3 TEXT , remark4 TEXT , cancelled TEXT, rev TEXT )',
        );

        await database.execute(
          'CREATE TABLE item(id INTEGER PRIMARY KEY, order_id TEXT, itemcode TEXT, location TEXT, description TEXT '
              + ' , furtherdescription TEXT , uom TEXT , rate TEXT , qty TEXT , focqty TEXT '
              + ' , smallestunitprice TEXT , unitprice TEXT, discount TEXT,  discountamt TEXT , taxtype TEXT , taxrate TEXT, tempid TEXT )',
        );
      },

      version: 1,
    );
  }

  Future<Database> initializeDB() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'kck_sale_database.db'),
    );
    return database;
  }

  Future<int> insertOrders(List<SaleOrderModel> orders) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var order in orders){
      try{
        result = await db.insert('orders', order.toDBMap());
      }catch(e){
        debugPrint(e.toString());
      }
    }
    return result;
  }

  Future<List<SaleOrderModel>> retrieveOrders() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('orders', orderBy: 'id', );
    return queryResult.map((e) => SaleOrderModel.fromDBMap(e)).toList();
  }

  Future<void> deleteOrders() async {
    final db = await initializeDB();
    await db.delete(
      'orders',
    );
  }

  Future<void> updateOrder(SaleOrderModel order) async {
    final db = await initializeDB();
    await db.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.soId],
    );
  }

  Future<void> deleteOrder(int id) async {
    final db = await initializeDB();
    await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

