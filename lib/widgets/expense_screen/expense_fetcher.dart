import 'package:expense/models/database_provider.dart';
import 'package:expense/widgets/expense_screen/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseFetcher extends StatefulWidget {
  ExpenseFetcher({super.key, required this.category});
  final String category;
  @override
  State<ExpenseFetcher> createState() => _ExpenseFetcherState();
}

class _ExpenseFetcherState extends State<ExpenseFetcher> {
  late Future _expenseList;
  Future _getExpenseList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchExpenses(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _expenseList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Consumer<DatabaseProvider>(builder: (_, db, __) {
                // var list = db.categories;
                return const ExpenseList();
              });
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
