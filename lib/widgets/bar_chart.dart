import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;
  BarChart({this.expenses});
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  iconSize: 20.0,
                  onPressed: () {}),
              Text(
                'Nov 10 2021-Nov 17 2021 ',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  iconSize: 20.0,
                  onPressed: () {})
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                amountSpent: expenses[0],
                label: 'Sun',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpent: expenses[1],
                label: 'Mon',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpent: expenses[2],
                label: 'Tue',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpent: expenses[3],
                label: 'Wed',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpent: expenses[4],
                label: 'Thur',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpent: expenses[5],
                label: 'Fri',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpent: expenses[6],
                label: 'Sat',
                mostExpensive: mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  Bar(
      {@required this.label,
      @required this.mostExpensive,
      @required this.amountSpent});
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final _maxHeight = 150.0;
  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxHeight;
    return Column(
      children: [
        Text(
          '\K\e\s ${amountSpent.toStringAsFixed(2)}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 9.0,
          ),
        ),
        Container(
          height: barHeight,
          width: 15.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
