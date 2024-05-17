import 'dart:math';

import 'package:expense_tacker/widgets/chart/chart.dart';
import 'package:expense_tacker/widgets/new_expense_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tacker/models/expense.dart';
import 'package:expense_tacker/widgets/expense_list/expenses_list.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    // TODO: implement createState
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExp = [
    Expense(
        title: 'Fluter course',
        amount: 500,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Web development',
        amount: 500,
        date: DateTime.now(),
        category: Category.work)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return New_Expense_Modal(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense exp) {
    setState(() {
      _registerdExp.add(exp);
    });
  }

  void _removeExpense(Expense expense) {
    final expense_index = _registerdExp.indexOf(expense);
    // print("removed expense");
    setState(() {
      _registerdExp.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerdExp.insert(expense_index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerdExp),
                Expanded(
                    child: ExpenseList(
                  expenses_list: _registerdExp,
                  oonremoveExpense: _removeExpense,
                )),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerdExp)),
                Expanded(
                    child: ExpenseList(
                  expenses_list: _registerdExp,
                  oonremoveExpense: _removeExpense,
                )),
              ],
            ),
    );
  }
}
