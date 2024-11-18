import 'package:expense/models/database_provider.dart';
import 'package:expense/screens/all_expense.dart';
import 'package:expense/screens/category_screen.dart';
import 'package:expense/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<DatabaseProvider>(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CategoryScreen.name,
      routes: {
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpense.name: (_) => const AllExpense(),
      },
      title: 'Expense App',
    );
  }
}
