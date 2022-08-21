import 'package:budget_app_practice/data/data.dart';
import 'package:budget_app_practice/models/category_model.dart';
import 'package:flutter/material.dart';

import '../helper/helper.dart';
import '../widgets/chat_bar.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            forceElevated: true,
            floating: true,
            backgroundColor: Colors.green,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Financial Budget"),
              centerTitle: true,
            ),
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
                iconSize: 30,
                color: Colors.white),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                iconSize: 30,
                color: Colors.white,
              )
            ],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  // height: 100,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ]),
                  child: ChatBar(weeklySpending),
                );
              } else {
                double totalAmountSpend = 0.0;
                Category category = categories[index - 1];
                for (var expense in category.expenses) {
                  totalAmountSpend += expense.cost;
                }
                return _buildCategory(category, totalAmountSpend);
              }
            }, childCount: 1 + categories.length),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(Category category, double totalAmountSpend) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => CategoryScreen(category))),
      child: Container(
        height: 100,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${(category.maxAmount - totalAmountSpend).toStringAsFixed(2)} / \$${category.maxAmount}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent =
                    (category.maxAmount - totalAmountSpend) / totalAmountSpend;
                double barWidth = percent * maxBarWidth;

                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                      height: 20,
                      width: barWidth,
                      decoration: BoxDecoration(
                          color: getColor(context, percent),
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
