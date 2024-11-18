import 'package:expense/models/database_provider.dart';
import 'package:expense/widgets/all_expense_screen/all_expense_list.dart';
import 'package:expense/widgets/all_expense_screen/expense_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllExpenseFetcher extends StatefulWidget {
  const AllExpenseFetcher({super.key});

  @override
  State<AllExpenseFetcher> createState() => _AllExpenseFetcherState();
}

class _AllExpenseFetcherState extends State<AllExpenseFetcher> {
  late Future _allExpenseList;
  Future _getAllExpenses() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchAllExpenses();
  }

  @override
  void initState() {
    super.initState();
    _allExpenseList = _getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _allExpenseList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    ExpenseSearch(),
                    Expanded(child: AllExpenseList()),
                  ]));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
