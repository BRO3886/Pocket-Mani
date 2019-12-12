import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import './bar.dart';

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
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get spending {
    return groupedExpenseValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      margin: EdgeInsets.only(top: 12, bottom: 12),
      padding: EdgeInsets.all(6),
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text('Last 7 days', textAlign: TextAlign.center,),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: groupedExpenseValues.map((data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: Bar(
                      amount: data['amount'],
                      label: data['day'],
                      percentOfTotal: spending == 0
                          ? 0.0
                          : (data['amount'] as double) / spending,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
