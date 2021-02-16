import 'package:budget_ui_app/data/data.dart';
import 'package:budget_ui_app/models/category_model.dart';
import 'package:budget_ui_app/models/expense_model.dart';
import 'package:budget_ui_app/screens/category_screen.dart';
import 'package:budget_ui_app/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:budget_ui_app/helpers/color_helpers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buldCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CategoryScreen(
              category: category,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.all(18.0),
        height: 100,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\K\e\s ${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/\K\e\s ${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxbarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxbarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }

                return Stack(
                  children: [
                    Container(
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 10.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            forceElevated: true,
            floating: true,
            leading: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
                iconSize: 30.0,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Budget App'),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  //color: Colors.red,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0)
                    ],
                  ),
                  child: BarChart(expenses: weeklySpending),
                );
              } else {
                final Category category = categories[index - 1];
                double totalAmountSpent = 0;
                category.expenses.forEach((Expense expense) {
                  totalAmountSpent += expense.cost;
                });
                return _buldCategory(category, totalAmountSpent);
              }
            }, childCount: 1 + categories.length),
          )
        ],
      ),

      // appBar: AppBar(
      //   title: Text('Budget App'),
      //   centerTitle: true,
      // ),
    );
  }
}
