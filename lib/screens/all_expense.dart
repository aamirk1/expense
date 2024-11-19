import 'package:expense/widgets/all_expense_screen/all_expense_fetcher.dart';
import 'package:flutter/material.dart';

class AllExpense extends StatefulWidget {
  const AllExpense({super.key});
  static const name = '/all_expense';

  @override
  State<AllExpense> createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('All Expenses'),),
      body: const AllExpenseFetcher(),
    );
  }
}
