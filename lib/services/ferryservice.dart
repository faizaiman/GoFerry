import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService
{
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async 
  {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'ferryApp.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future _onCreate(Database db, int version) async
  {
    await db.execute
    (
      '''
        CREATE TABLE user
        (
          user_id INT PRIMARY KEY AUTOINCREMENT,
          f_name TEXT,
          l_name TEXT,
          username TEXT,
          password TEXT,
          mobilehp TEXT
        ),
      '''
    );
    await db.execute
    (
      '''
      CREATE TABLE ferryticket
      (
        book_id INT PRIMARY KEY AUTOINCREMENT,
        depart_date TEXT,
        journey TEXT,
        depart_route TEXT,
        dest_route TEXT,
        FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE SET NULL',
      ),
      '''
    );
  }

  
}