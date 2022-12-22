import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:goferry/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'ferryticketapp.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user
        (
          user_id INT PRIMARY KEY AUTOINCREMENT,
          f_name TEXT,
          l_name TEXT,
          username TEXT,
          password TEXT,
          mobilehp TEXT
        ),
      ''');
    await db.execute('''
      CREATE TABLE ferryticket
      (
        book_id INT PRIMARY KEY AUTOINCREMENT,
        depart_date TEXT,
        journey TEXT,
        depart_route TEXT,
        dest_route TEXT,
        FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE SET NULL',
      ),
      ''');
  }

  Future<List<FerryTicket>> getFerryTickets() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('ferryticket');
    return List.generate(
        maps.length, (index) => FerryTicket.fromMap(maps[index]));
  }

  Future<FerryTicket> ferryTicket(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('ferryticket', where: 'id = ?', whereArgs: [id]);
    return FerryTicket.fromMap(maps[0]);
  }

  Future<void> insertFerryTicket(FerryTicket ferryTicket) async {
    final db = await _databaseService.database;
    await db.insert(
      'ferryticket',
      ferryTicket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editFerryTicket(FerryTicket ferryTicket) async {
    final db = await _databaseService.database;
    await db.update(
      'ferryticket',
      ferryTicket.toMap(),
      where: 'id = ?',
      whereArgs: [ferryTicket.book_id],
    );
  }

  Future<void> deleteFerryTicket(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'ferryTicket',
      where: 'id =?',
      whereArgs: [id],
    );
  }

  Future<void> registerUser(User user) async {
    final db = await _databaseService.database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> userLogin(String username, String password) async {
    final db = await _databaseService.database;
    var res = await db.rawQuery(
        "SELECT * FROM user WHERE username = '$username' and password = '$password'");
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    } else {
      return null;
    }
  }
}
