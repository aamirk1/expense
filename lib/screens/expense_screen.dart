import 'package:expense/widgets/expense_screen/expense_fetcher.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = '/expense_screen';

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Expenses Screen'))),
      body: ExpenseFetcher(
        category: category,
      ),
    );
  }
}
