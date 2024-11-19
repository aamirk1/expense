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
          title: Text('Delete ${exp!.title} ?'),
          content: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Don\'t delete'),
              ),
              const SizedBox(
                width: 5.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
    
                    provider.deleteExpense(
                        exp!.id, exp!.category, exp!.amount);
                  },
                  child: const Text('Delete'))
            ],
          ),
        );
  }
}
