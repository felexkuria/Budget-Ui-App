import 'package:budget_ui_app/helpers/color_helpers.dart';
import 'package:budget_ui_app/models/category_model.dart';
import 'package:budget_ui_app/models/expense_model.dart';
import 'package:budget_ui_app/widgets/radial_painter.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpenxes() {
    List<Widget> expensesList = [];
    widget.category.expenses.forEach((Expense expense) {
      expensesList.add(
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: 80.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black12,
                blurRadius: 6.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expense.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '-\K\s\h${expense.cost.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return Column(
      children: expensesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense) {
      totalAmountSpent += expense.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        //controller: controller,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              height: 250.0,
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      offset: Offset(0, 2),
                      color: Colors.black12,
                    ),
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0,
                ),
                child: Center(
                  child: Text(
                    '\K\s\h${amountLeft.toStringAsFixed(2)}/ \K\s\h${widget.category.maxAmount}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            _buildExpenxes(),
          ],
        ),
      ),
    );
  }
}
