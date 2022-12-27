import 'dart:io';
import 'package:goferry/pages/displayFerry.dart';
import 'package:flutter/material.dart';
import 'package:goferry/models/ferryticket.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/pages/displayFerry.dart';
import 'package:goferry/pages/login/loginFormWidget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:goferry/pages/login/loginScreen.dart';

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
    final path = join(databasePath, 'ferryticket.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE user
      (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        f_name TEXT,
        l_name TEXT,
        username TEXT,
        password TEXT,
        mobilehp TEXT
      )
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE ferryticket
      (
        book_id INTEGER PRIMARY KEY AUTOINCREMENT,
        depart_date TEXT, 
        journey TEXT, 
        depart_route TEXT, 
        dest_route TEXT, 
        FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE SET NULL
      )
      ''',
    );
  }

  Future<User> user(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('user', where: 'user_id = ?', whereArgs: [id]);
    return User.fromMap(maps[0]);
  }

  Future<List<FerryTicket>> getFerryTickets() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('ferryticket');
    return List.generate(
        maps.length, (index) => FerryTicket.fromMap(maps[index]));
  }

  Future<List<User>> getUser() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    return List.generate(maps.length, (index) => User.fromMap(maps[index]));
  }

  Future<FerryTicket> ferryTicket(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('ferryticket', where: 'book_id = ?', whereArgs: [id]);
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
      where: 'book_id = ?',
      whereArgs: [ferryTicket.book_id],
    );
  }

  Future<void> updateUser(User user) async {
    final db = await _databaseService.database;
    await db.update(
      'user',
      user.toMap(),
      where: 'user_id = ?',
      whereArgs: [user.user_id],
    );
  }

  Future<void> deleteFerryTicket(int? id) async {
    final db = await _databaseService.database;
    await db.delete(
      'ferryTicket',
      where: 'book_id =?',
      whereArgs: [id],
    );
  }

  Future<void> registerUser(User user, BuildContext context) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [user.username],
    );
    if (result.isNotEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username already exist.')),
      );
    } else {
      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully registered account')),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<User?> userLogin(User user, BuildContext context) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> result = await db.query(
      'login',
      where: 'username = ? and password = ?',
      whereArgs: [user.username, user.password],
    );
    if (result.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Wrong password or username. Log in unsuccessful.')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Login Successful. Hello, ${user.username}., ${user.user_id.toString()}')),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DisplayPage(user: user)),
      );
    }
  }
}
