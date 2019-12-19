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
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
  AppBar appBar(Color color) {
    return AppBar(
      title: Text(
        'Pocket Mani',
        style: TextStyle(color: color),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  final List<Expense> userExpensesList = [];
  void _addNewTransaction(String title, double amount, DateTime date) {
    final newExp = Expense(
        title: title,
        date: date,
        amount: amount,
        id: DateTime.now().toString());

    setState(() {
      userExpensesList.add(newExp);
      userExpensesList.sort((a,b) => b.date.compareTo(a.date));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userExpensesList.removeWhere((exp) => exp.id == id);
    });
  }

  void _showBottomSheetMenu(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Theme.of(ctx).primaryColor,
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
      appBar: appBar(Theme.of(context).textTheme.title.color),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar(Theme.of(context).textTheme.title.color)
                              .preferredSize
                              .height -
                          MediaQuery.of(context).padding.top) *
                      0.40,
                  child: Graph(_getRecentTransactions())),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar(Theme.of(context).textTheme.title.color)
                              .preferredSize
                              .height -
                          MediaQuery.of(context).padding.top) *
                      0.60,
                  child: ExpenseList(userExpensesList, _deleteTransaction)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheetMenu(context),
        tooltip: 'Add Expense',
        child: Icon(Icons.add),
      ),
    );
  }
}
