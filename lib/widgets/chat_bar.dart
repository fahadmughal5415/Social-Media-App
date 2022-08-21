import 'package:flutter/material.dart';

class ChatBar extends StatelessWidget {
  final List<double> expense;

  // ignore: use_key_in_widget_constructors
  const ChatBar(this.expense);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0.0;
    for (var price in expense) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text(
            "Weekly Spending",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30),
              const Text(
                "Aug 18, 2022 - Aug 24, 2022",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 30),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  label: "Sun",
                  spendAmount: expense[0],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Mon",
                  spendAmount: expense[1],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Tue",
                  spendAmount: expense[2],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Wed",
                  spendAmount: expense[3],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Thu",
                  spendAmount: expense[4],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Fri",
                  spendAmount: expense[5],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Sat",
                  spendAmount: expense[6],
                  mostExpensive: mostExpensive),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double mostExpensive;

  // ignore: use_key_in_widget_constructors
  const Bar(
      {required this.label,
      required this.spendAmount,
      required this.mostExpensive});

  final double _maxBarHeight = 150;

  @override
  Widget build(BuildContext context) {
    final double barHeight = spendAmount / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          "\$${barHeight.toStringAsFixed(0)}",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: barHeight,
          width: 16,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(6)),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
