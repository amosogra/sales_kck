

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sales_kck/model/post/CreateTempModel.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/model/post/SoList.dart';
import 'package:sales_kck/model/post/TempDraftModel.dart';
import 'package:sqflite/sqflite.dart';

class TempDraftDBHelper{


  Future<Database> initializeDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'kck_sale_database.db'),
    );
    return database;
  }


  Future<int> insertTemps(List<TempDraftModel> items) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var item in items){
      try{
        result = await db.insert('temp_draft', item.toMap());
      }catch(e){
        debugPrint(e.toString());
      }
    }
    return result;
  }


  Future<List<TempDraftModel>> retrieveTemps() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('temp_draft', orderBy: 'id', );
    return queryResult.map((e) => TempDraftModel.fromMap(e)).toList();
  }

  Future<void> deleteTemps() async {
    final db = await initializeDB();
    await db.delete(
      'temp_draft',
    );
  }

  Future<void> updateTemp(CreateTempModel item) async {
    final db = await initializeDB();
    await db.update(
      'temp_draft',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.docno],
    );
  }

  Future<void> deleteTemp(int id) async {
    final db = await initializeDB();
    await db.delete(
      'temp_draft',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}