

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sqflite/sqflite.dart';

class ItemDBHelper{

  Future<Database> initializeTotalDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'kck_sale_database.db'),
      onCreate: (database, version) async {

        await database.execute(
          'CREATE TABLE item(id INTEGER PRIMARY KEY, itemcode TEXT, location TEXT, description TEXT '
              + ' , furtherdescription TEXT , uom TEXT , rate TEXT , qty TEXT , focqty TEXT '
              + ' , smallestunitprice TEXT , unitprice TEXT, discount TEXT,  discountamt TEXT , taxtype TEXT , taxrate TEXT, tempid TEXT )',
        );

      },

      version: 1,
    );
  }

  Future<Database> initializeDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'kck_sale_database.db'),
    );
    return database;
  }

  Future<int> insertItems(List<SoList> items) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var item in items){
      try{
        result = await db.insert('item', item.toMap());
      }catch(e){
        debugPrint(e.toString());
      }
    }
    return result;
  }


  Future<List<SoList>> retrieveItems() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('item', orderBy: 'id', );
    return queryResult.map((e) => SoList.fromMap(e)).toList();
  }


  Future<List<SoList>> retrieveItemsByOrderId(int id) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('item',
      where: 'order_id = ?',
      whereArgs: [id],
      orderBy: 'id', );
    return queryResult.map((e) => SoList.fromMap(e)).toList();
  }





  Future<void> deleteItems() async {
    final db = await initializeDB();
    await db.delete(
      'item',
    );
  }

  Future<void> updateItem(SaleOrderModel item) async {
    final db = await initializeDB();
    await db.update(
      'item',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.soId],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await initializeDB();
    await db.delete(
      'item',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteByOrder(int id) async {
    final db = await initializeDB();
    await db.delete(
      'item',
      where: 'order_id = ?',
      whereArgs: [id],
    );
  }


}