import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  @override
  Widget build(BuildContext context) {
    final _title = TextEditingController();
    final _amount = TextEditingController();
    DateTime? _date;
    _pickDate() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        setState(() {
          _date = pickedDate;
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
            controller: _title,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 20,
          ), // amount
          TextField(
            keyboardType: TextInputType.number,
            controller: _amount,
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
                  child:
                      Text(_date != null ? _date.toString() : 'Select Date')),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.calendar_month))
            ],
          )
        ],
      )),
    );
  }
}
