import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:expense_tacker/models/expense.dart';

final formatter = DateFormat.yMd();

class New_Expense_Modal extends StatefulWidget {
  New_Expense_Modal({super.key, required this.onAddExpense});

  final void Function(Expense exp) onAddExpense;
  @override
  State<New_Expense_Modal> createState() {
    // TODO: implement createState
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<New_Expense_Modal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selected_date;
  Category _selected_cateogry = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final first_date = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: first_date, lastDate: now);
    setState(() {
      selected_date = pickedDate;
    });
  }

  void _submit_expense_date() {
    final enter_amount = double.tryParse(_amountController.text);
    final amountIsinvalid = enter_amount == null || enter_amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsinvalid ||
        selected_date == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content:
              Text('Please make sure a valid title,amount,time was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enter_amount,
        date: selected_date!,
        category: _selected_cateogry));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _titleController.dispose();
      _amountController.dispose();

      super.dispose();
    }

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    // TODO: implement build
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 50, 16, keyboardSpace + 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(label: Text('Title')),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(label: Text('Amount')),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(selected_date == null
                        ? 'No date selected'
                        : formatter.format(selected_date!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(Icons.calendar_month))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selected_cateogry,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selected_cateogry = value;
                    });
                  },
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: _submit_expense_date,
                    child: Text('Save expense'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
