import 'package:expense/models/database_provider.dart';
import 'package:expense/screens/all_expense.dart';
import 'package:expense/widgets/category_screen/category_list.dart';
import 'package:expense/widgets/category_screen/total_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {
  late Future _categoryList;
  Future _getCategoryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchCategories();
  }

  @override
  void initState() {
    super.initState();
    _categoryList = _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _categoryList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              // var list = db.categories;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 250,
                      child: TotalChart(),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Expenses',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AllExpense.name);
                            },
                            child: const Text('View All'),
                          )
                        ]),
                    const Expanded(child: CategoryList()),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
