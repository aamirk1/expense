import 'package:expense/widgets/category_screen/category_fetcher.dart';
import 'package:expense/widgets/expens_form.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Category',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.blue,
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          showModalBottomSheet(context: context,isScrollControlled: true, builder: (_) => const ExpenseForm());
        },
      ),
    );
  }
}
