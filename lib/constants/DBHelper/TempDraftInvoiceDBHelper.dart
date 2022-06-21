

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sales_kck/model/post/outstanding_model.dart';
import 'package:sqflite/sqflite.dart';

class TempDraftInvoiceDBHelper{


  Future<Database> initializeDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'kck_sale_database.db'),
    );
    return database;
  }

  Future<int> insertTempInvoice(List<OutstandingARS> items) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var item in items){
      try{
        result = await db.insert('temp_draft_invoice', item.toMap());
      }catch(e){
        debugPrint(e.toString());
      }
    }
    return result;
  }


  Future<List<OutstandingARS>> retrieveTempInvoices() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('temp_draft_invoice', orderBy: 'id', );
    return queryResult.map((e) => OutstandingARS.fromMap(e)).toList();
  }

  Future<List<OutstandingARS>> retrieveTRInvoicesBySaved(trId) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('temp_draft_invoice',
      where: 'trId = ?',
      whereArgs: [trId], orderBy: 'id', );
    return queryResult.map((e) => OutstandingARS.fromMap(e)).toList();
  }


  Future<void> deleteTempInvoice() async {
    final db = await initializeDB();
    await db.delete(
      'temp_draft_invoice',
    );
  }

  Future<void> updateTempInvoice(OutstandingARS item) async {
    final db = await initializeDB();
    await db.update(
      'temp_draft_invoice',
      item.toMap(),
      where: 'trId = ?',
      whereArgs: [item.trId],
    );
  }

  Future<void> deleteTemp(int id) async {
    final db = await initializeDB();
    await db.delete(
      'temp_draft_invoice',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}