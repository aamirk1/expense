import 'package:expense/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/expense.dart';

class confirmBox extends StatelessWidget {
  const confirmBox({
    super.key,
    required this.exp,
  });

  final Expense? exp;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      title: Center(
        child: Text(
          'Delete ${exp!.title}?',
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Don\'t delete',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);

                provider.deleteExpense(exp!.id, exp!.category, exp!.amount);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ))
        ],
      ),
    );
  }
}
