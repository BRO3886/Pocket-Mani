import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExp;

  ExpenseList(this.expenses, this.deleteExp);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18),
      child: Container(
        height: 470,
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
                  return Padding(
                    padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(ctx).accentColor,
                          foregroundColor: Theme.of(ctx).cardColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            child: FittedBox(
                                child: Text('₹ ${expenses[index].amount}')),
                          ),
                        ),
                        title: Text(
                          '${expenses[index].title}',
                          style: Theme.of(ctx).textTheme.title,
                        ),
                        subtitle: Text(DateFormat('EEE, d/M/y')
                            .format(expenses[index].date)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () {
                            deleteExp(expenses[index].id);
                          },
                        ),
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
