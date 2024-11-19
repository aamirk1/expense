import 'package:expense/models/database_provider.dart';
import 'package:expense/widgets/expense_screen/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var exList = db.expenses;
        return exList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: exList.length,
                itemBuilder: (_, i) => ExpenseCard(
                      exp: exList[i],
                    ))
            : const Center(
                child: Text('No Expenses Added'),
              );
      },
    );
  }
}
