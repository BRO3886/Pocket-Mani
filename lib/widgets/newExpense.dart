import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExp extends StatefulWidget {
  final Function addExpense;
  NewExp(this.addExpense);

  @override
  _NewExpState createState() => _NewExpState();
}

class _NewExpState extends State<NewExp> {
  final amountController = TextEditingController();

  final titleController = TextEditingController();

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount.isNegative) {
      return;
    }

    widget.addExpense(title, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            FlatButton(
              onPressed: submitData,
              child: Text('Add Expense', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
