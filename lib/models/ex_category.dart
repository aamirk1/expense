import 'package:flutter/material.dart';

import '../constants/icons.dart';

class ExpenseCategory {
  late final String title;
  int entries = 0;
  double totalAmount = 0.0;
  late final IconData icon;

// Constructor

  ExpenseCategory(
      {required this.title,
      required this.entries,
      required this.totalAmount,
      required this.icon});

// we need a method to convert this 'model' to a 'Map'.
// so that we can insert it into a database
  Map<String, dynamic> toMap() => {
        'title': title,
        'entries': entries,
        'totalAmount': totalAmount.toString(),
      };
  factory ExpenseCategory.fromString(Map<String, dynamic> value) =>
      ExpenseCategory(
        title: value['title'],
        entries: value['entries'],
        totalAmount: double.parse(value['totalAmount']),
        icon: icons[value['title']]!,
      );
}
