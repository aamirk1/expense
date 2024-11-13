import 'package:expense/constants/icons.dart';
import 'package:expense/models/database_provider.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime? date;
  String initialValue = 'Other';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);

    _pickDate() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        setState(() {
          date = pickedDate;
        });
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Column(
        children: [
          // title
          TextField(
            controller: title,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 20,
          ), // amount
          TextField(
            keyboardType: TextInputType.number,
            controller: amount,
            decoration: const InputDecoration(
              label: Text('Amount'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(date != null ? date.toString() : 'Select Date')),
              IconButton(
                  onPressed: () {
                    _pickDate();
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Expanded(child: Text('Category')),
              Expanded(
                  child: DropdownButton(
                items: icons.keys
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: initialValue,
                onChanged: (value) {
                  setState(() {
                    initialValue = value.toString();
                  });
                },
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (title.text != '' && amount.text != '' && date != null) {
                  final file = Expense(
                    id: 0,
                    title: title.text,
                    amount: double.parse(amount.text),
                    date: date != null ? date! : DateTime.now(),
                    category: initialValue,
                  );
                  provider.addExpense(file);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Expense'))
        ],
      )),
    );
  }
}
