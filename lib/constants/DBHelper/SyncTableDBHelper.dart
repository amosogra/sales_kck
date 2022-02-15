import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sales_kck/model/post/sync_model.dart';
import 'package:sqflite/sqflite.dart';

class SyncTableDBHelper{

  Future<Database> initializeDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'kck_sale_database.db'),
    );
    return database;
  }


  Future<int> insertSyncs(List<SyncModel> items) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var item in items){
      try{
        result = await db.insert('sync_table', item.toMap());
      }catch(e){
        debugPrint(e.toString());
      }
    }
    return result;
  }


  Future<List<SyncModel>> retrieveSyncs() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('sync_table', orderBy: 'id', );
    return queryResult.map((e) => SyncModel.fromMap(e)).toList();
  }

  Future<void> deleteSyncs() async {
    final db = await initializeDB();
    await db.delete(
      'sync_table',
    );
  }

  Future<void> updateSync(SyncModel item) async {
    final db = await initializeDB();
    var res = await db.update(
      'sync_table',
      item.toMap(),
      where: 'slug = ?',
      whereArgs: [item.slug],
    );
    debugPrint(res.toString());
  }

  Future<void> deleteSync(int id) async {
    final db = await initializeDB();
    await db.delete(
      'sync_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}