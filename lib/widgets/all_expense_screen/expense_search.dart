import 'package:flutter/material.dart';

class ExpenseSearch extends StatefulWidget {
  const ExpenseSearch({super.key});

  @override
  State<ExpenseSearch> createState() => _ExpenseSearchState();
}

class _ExpenseSearchState extends State<ExpenseSearch> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: 'Search Expenses',),
    );
  }
}
