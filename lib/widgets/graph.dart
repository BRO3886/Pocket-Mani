import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class Graph extends StatelessWidget {
  final List<Expense> recentExpenses;

  Graph(this.recentExpenses);

  List<Map<String, Object>> get groupedExpenseValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recentExpenses.length; i++) {
        if (recentExpenses[i].date.day == weekDay.day &&
            recentExpenses[i].date.month == weekDay.month &&
            recentExpenses[i].date.year == weekDay.year) {
          totalSum += recentExpenses[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);


      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedExpenseValues);
    return Container(
      padding: EdgeInsets.all(6),
      child: Card(
        child: Text('Graph'),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      width: double.infinity,
      height: 300,
      margin: EdgeInsets.only(top: 12, bottom: 12),
    );
  }
}
