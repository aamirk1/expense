import 'package:expense/models/database_provider.dart';
import 'package:expense/widgets/expense_screen/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllExpenseList extends StatelessWidget {
  const AllExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.expenses;
      return list.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: list.length,
              itemBuilder: (_, i) => ExpenseCard(exp: list[i]))
          : const Center(
              child: Text('No Entries Found'),
            );
    });
  }
}
