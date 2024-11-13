import 'package:expense/models/ex_category.dart';
import 'package:expense/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final ExpenseCategory category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ExpenseScreen.name, arguments: category.title);
      },
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(category.icon),
      ),
      title: Text(category.title),
      subtitle: Text('entries ${category.entries.toString()}'),
      trailing: Text(NumberFormat.currency(locale: 'en_IN', symbol: '₹')
          .format(category.totalAmount)),
    );
  }
}
