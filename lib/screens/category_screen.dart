import 'package:budget_app_practice/helper/helper.dart';
import 'package:budget_app_practice/widgets/radial_painter.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  // ignore: use_key_in_widget_constructors
  const CategoryScreen(this.category);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmountSpend = 0.0;
    for (var expense in widget.category.expenses) {
      totalAmountSpend += expense.cost;
    }
    final double amountLeft = widget.category.maxAmount - totalAmountSpend;
    double percent = amountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.category.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black45,
                        offset: Offset(
                          0,
                          2,
                        ),
                        blurRadius: 6.0)
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    bgColor: Colors.grey.shade200,
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15),
                child: Center(
                    child: Text(
                  "\$${(widget.category.maxAmount - totalAmountSpend).toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                )),
              ),
            ),
            _buildCategoryItems(),
          ],
        ),
      ),
    );
  }

  _buildCategoryItems() {
    List<Widget> expenseList = [];
    for (var expense in widget.category.expenses) {
      expenseList.add(Container(
        height: 80,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, offset: Offset(0, 2), blurRadius: 6.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(expense.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                "\$${expense.cost.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ));
    }
    return Column(
      children: expenseList,
    );
  }
}
