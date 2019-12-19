import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExp extends StatefulWidget {
  final Function addExpense;
  NewExp(this.addExpense);

  @override
  _NewExpState createState() => _NewExpState();
}

class _NewExpState extends State<NewExp> {
  final _amountController = TextEditingController();

  final _titleController = TextEditingController();

  DateTime _datepickerController;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount.isNegative || _datepickerController == null) {
      return;
    }

    widget.addExpense(title, amount, _datepickerController);

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _datepickerController = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Card(
        elevation: 0.0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        (_datepickerController == null)
                            ? 'No date added yet'
                            : '${DateFormat.yMMMEd().format(_datepickerController)}',
                        style: (_datepickerController == null)
                            ? TextStyle(color: Theme.of(context).errorColor)
                            : TextStyle(
                                color: Theme.of(context).textTheme.title.color),
                      ),
                      FlatButton(
                        child: Text(
                          'Add Date',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        onPressed: _datePicker,
                      ),
                    ],
                  ),
                  RaisedButton(
                    elevation: 0,
                    onPressed: _submitData,
                    child: Text(
                      'Add Expense',
                      style:
                          TextStyle(color: Theme.of(context).backgroundColor),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
