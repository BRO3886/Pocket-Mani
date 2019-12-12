import 'package:flutter/material.dart';
import 'package:pocket_mani/widgets/newExpense.dart';
import './widgets/graph.dart';
import './models/expense.dart';
import './widgets/expenseList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
          primarySwatch: Colors.green,
          primaryColorDark: Colors.black38,
          brightness: Brightness.dark),
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
      ),
      home: MyHomePage(title: 'Pocket Mani'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> userExpensesList = [
  ];
  void _addNewTransaction(String title, double amount, DateTime date) {
    final newExp = Expense(
        title: title,
        date: date,
        amount: amount,
        id: DateTime.now().toString());

    setState(() {
      userExpensesList.add(newExp);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userExpensesList.removeWhere((exp) => exp.id == id);
    });
  }

  void _showBottomSheetMenu(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewExp(_addNewTransaction);
        });
  }

  List _getRecentTransactions() {
    return userExpensesList.where((exp) {
      return exp.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Graph(_getRecentTransactions()),
              ExpenseList(userExpensesList, _deleteTransaction),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheetMenu(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
