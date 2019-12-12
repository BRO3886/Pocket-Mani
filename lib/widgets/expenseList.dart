import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseList(this.expenses);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18),
      child: Container(
        height: 435,
        child: expenses.isEmpty
            ? Container(
                height: 50,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Uh Oh! You haven\'t added any expenses yet.\nTap \'+\' to add an expense.',
                      style: Theme.of(context).textTheme.body1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset('assets/images/confused.png',
                        width: 72, height: 72),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 4, right: 4),
                    child: Card(
                      color: Theme.of(context).cardColor,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(4),
                            child: Text(
                              '₹ ${expenses[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  expenses[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  DateFormat('EEE, d/M/y')
                                      .format(expenses[index].date),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: expenses.length,
              ),
      ),
    );
  }
}
