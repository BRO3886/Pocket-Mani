import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentOfTotal;

  Bar(
      {@required this.label,
      @required this.amount,
      @required this.percentOfTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: 18,
              child: FittedBox(child: Text('₹${amount.toStringAsFixed(0)}'))),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 180,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[100], width: 0.5),
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor: percentOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(label),
        ],
      ),
    );
  }
}
