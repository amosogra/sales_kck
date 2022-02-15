import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
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
              + ' , totalAmt TEXT , remark1 TEXT, remark2 TEXT,  remark3 TEXT , remark4 TEXT , cancelled TEXT, rev TEXT ,synced TEXT)',
        );

        await database.execute(
          'CREATE TABLE item(id INTEGER PRIMARY KEY, order_id TEXT, itemcode TEXT, location TEXT, description TEXT '
              + ' , furtherdescription TEXT , uom TEXT , rate TEXT , qty TEXT , focqty TEXT '
              + ' , smallestunitprice TEXT , unitprice TEXT, discount TEXT,  discountamt TEXT , taxtype TEXT , taxrate TEXT, tempid TEXT)',
        );

        await database.execute(
          'CREATE TABLE temp(id INTEGER PRIMARY KEY, docno TEXT, debtorcode TEXT, projectcode TEXT, departmentcode TEXT '
              + ' , currencycode TEXT , description TEXT , secondreceiptno TEXT , salesagent TEXT , receiveddate TEXT '
              + ' , chequedate TEXT )',
        );

        await database.execute(
          'CREATE TABLE temp_draft(id INTEGER PRIMARY KEY, receipt_no TEXT, receipt_from TEXT, receipt_date TEXT, payment_date TEXT '
              + ' , payment_method TEXT , cheque_no TEXT , payment_amount TEXT , isSaved TEXT)',
        );

        await database.execute(
          'CREATE TABLE sync_table(id INTEGER PRIMARY KEY, title TEXT, total_count TEXT, last_synced_date TEXT, slug TEXT )',
        );

        await database.execute(
          'CREATE TABLE temp_draft_customer(custId INTEGER PRIMARY KEY, companyCode TEXT, accNo TEXT, name TEXT, docNumber TEXT '
              + ' , docDate TEXT , addr1 TEXT , addr2 TEXT , addr3 TEXT , addr4 TEXT '
              + ' , attention TEXT , defDisplayTerm TEXT, taxType TEXT,  phone1 TEXT , phone2 TEXT , isActive TEXT, rev TEXT , deleted TEXT, temp_draft_id INTEGER)',
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

  Future<List<SaleOrderModel>> retrieveOrdersById(int id) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('orders',
      where: 'id = ?',
      whereArgs: [id], orderBy: 'id', );

    return queryResult.map((e) => SaleOrderModel.fromDBMap(e)).toList();
  }

  Future<List<SaleOrderModel>> retrieveOrdersBySynced() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('orders',
      where: 'synced = ?',
      whereArgs: ["1"], orderBy: 'id', );

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
      order.toDBMap(),
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

