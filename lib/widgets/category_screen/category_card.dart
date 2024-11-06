import 'package:expense/models/ex_category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final ExpenseCategory category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(category.icon),
      ),
      title: Text(category.title),
      subtitle: Text('entries ${category.entries.toString()}'),
      trailing: Text('₹ ${category.totalAmount.toStringAsFixed(2)}'),
    );
  }
}
