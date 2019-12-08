import 'package:flutter/material.dart';


class Graph extends StatelessWidget {
  final double graphRadius;

  Graph({this.graphRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Text('Graph'),
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(graphRadius)),
      ),
      width: double.infinity,
      height: 300,
      margin: EdgeInsets.only(top: 12, bottom: 12),
      
    );
  }
}
