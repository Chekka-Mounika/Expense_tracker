import 'package:flutter/material.dart';
import 'package:expense_tacker/models/expense.dart';
import 'package:expense_tacker/widgets/expense_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key, required this.expenses_list, required this.oonremoveExpense});

  final List<Expense> expenses_list;
  final void Function(Expense exp) oonremoveExpense;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: expenses_list.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses_list[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: Theme.of(context).cardTheme.margin,
        ),
        onDismissed: (direction) {
          oonremoveExpense(expenses_list[index]);
        },
        child: ExpenseItem(expense: expenses_list[index]),
      ),
    );
  }
}
