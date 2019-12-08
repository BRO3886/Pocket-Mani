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
      darkTheme: ThemeData(primarySwatch: Colors.green, primaryColorDark: Colors.black38, brightness: Brightness.dark),
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
    Expense(id: '1', title: 'Chips', amount: 20, date: DateTime.now()),
    Expense(id: '2', title: 'Stationery', amount: 400, date: DateTime.now()),
    Expense(id: '3', title: 'Pizza', amount: 129, date: DateTime.now()),
    Expense(id: '4', title: 'FC', amount: 30, date: DateTime.now()),
  ];
  void _addNewTransaction(String title, double amount){
    final newExp = Expense(title: title, date: DateTime.now(), amount: amount,id: '123');

    setState(() {
      userExpensesList.add(newExp);
    });
  }
  
  
  void _showBottomSheetMenu(BuildContext ctx){
    showModalBottomSheet(context: ctx,builder: (_){
      return NewExp(_addNewTransaction);
    }); 
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Graph(
                graphRadius: 12,
              ),
              ExpenseList(userExpensesList),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_showBottomSheetMenu(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
