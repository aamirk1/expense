import 'package:expense/constants/icons.dart';
import 'package:expense/widgets/expense_screen/confirm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, this.exp});
  final Expense? exp;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(exp!.id),
      confirmDismiss: (_) async {
        showDialog(context: context, builder: (_) => confirmBox(exp: exp));
        return null;
      },
      child: ListTile(
        // onTap: () {
        //   Navigator.of(context)
        //       .pushNamed(ExpenseScreen.name, arguments: expense.title);
        // },
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icons[exp!.category]),
        ),
        title: Text(exp!.title),
        subtitle: Text(DateFormat('MMMM dd, yyyy').format(exp!.date)),
        trailing: Text(NumberFormat.currency(locale: 'en_IN', symbol: '₹')
            .format(exp!.amount)),
      ),
    );
  }
}
