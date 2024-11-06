import 'package:expense/constants/icons.dart';
import 'package:expense/models/ex_category.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider with ChangeNotifier {
  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;

  List<Expense> _expenses = [];
  List<Expense> get expenses => expenses;
  Database? _database;
  Future<Database> get database async {
    // database directory
    final dbDirectory = await getDatabasesPath();
    // database name
    const dbName = 'expense_tc.db';
    // full path
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb, // will create this seperately
    );
    return _database!;
  }

  static const cTable = 'categoryTable';
  static const eTable = 'expenseTable';

  Future<void> _createDb(Database db, int version) async {
    await db.transaction((txn) async {
      // category table
      await txn.execute('''CREATE TABLE $cTable(
      title TEXT,
      entries INTEGER,
      totalAmount TEXT
    )''');

      // expense table
      await txn.execute('''CREATE TABLE $eTable(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    amount TEXT,
    date TEXT,
    category TEXT
    )''');

      for (var i = 0; i < icons.length; i++) {
        await txn.insert(cTable, {
          'title': icons.keys.toList()[i],
          'entries': 0,
          'totalAmount': (0.0).toString(),
        });
      }
    });
  }

  Future<List<ExpenseCategory>> fetchCategories() async {
    // get the datebase
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(cTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<ExpenseCategory> nList = List.generate(converted.length,
            (index) => ExpenseCategory.fromString(converted[index]));
        _categories = nList;
        return _categories;
      });
    });
  }

  Future<void> updateCategory(
    String category,
    int nEntries,
    double nTotalAmount,
  ) async {
    final db = await database;
    await db.transaction(
      (txn) async {
        await txn
            .update(
                cTable,
                {
                  'entries': nEntries,
                  'totalAmount': nTotalAmount.toString(),
                },
                where: 'title == ?',
                whereArgs: [category])
            .then((_) {
          var file =
              _categories.firstWhere((element) => element.title == category);
          file.entries = nEntries;
          file.totalAmount = nTotalAmount;
          notifyListeners();
        });
      },
    );
  }

  Future<void> addExpense(Expense exp) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .insert(
        eTable,
        exp.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((generatedId) {
        final file = Expense(
            id: generatedId,
            title: exp.title,
            amount: exp.amount,
            date: exp.date,
            category: exp.category);

        _expenses.add(file);
        notifyListeners();
        var data = calculationEntriesAndAmount(exp.category);
        updateCategory(exp.category, data['entries'], data['totalAmount']);
      });
    });
  }

  Map<String, dynamic> calculationEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _expenses.where((element) => element.category == category);
    for (var i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }
}
