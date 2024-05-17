import 'package:expense_tacker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tacker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({required this.expense, super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    expense.amount.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        categoryIcons[expense.category],
                      ),
                      SizedBox(width: 8),
                      Text(
                        expense.getFormattedDate(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
