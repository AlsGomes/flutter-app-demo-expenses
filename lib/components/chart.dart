import 'package:expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final today = DateTime.now().subtract(Duration(days: index));
      final day = today.day;
      final month = today.month;
      final year = today.year;

      final initials = DateFormat("E").format(today)[0];

      bool hasTransaction = _recentTransactions
          .where((t) =>
              t.date.day.compareTo(day) == 0 &&
              t.date.month.compareTo(month) == 0 &&
              t.date.year.compareTo(year) == 0)
          .isNotEmpty;

      double totalAmountInDay = !hasTransaction
          ? 0.00
          : _recentTransactions
              .where((t) =>
                  t.date.day.compareTo(day) == 0 &&
                  t.date.month.compareTo(month) == 0 &&
                  t.date.year.compareTo(year) == 0)
              .reduce((t1, t2) => Transaction(
                    date: t1.date,
                    id: "_",
                    title: "T",
                    value: t1.value + t2.value,
                  ))
              .value;

      final element = {
        "day": initials,
        "value": totalAmountInDay,
      };

      return element;
    }).reversed.toList();
  }

  double get maxAmountInWeek {
    /* var max = 0.0;

    for (var i = 0; i < groupedTransactions.length; i++) {
      final double actualAmount =
          double.parse(groupedTransactions[i]["value"].toString());

      if (actualAmount > max) {
        max = actualAmount;
      }
    } */

    double max = groupedTransactions.fold(0.0, (acc, t) {
      return acc += (t["value"] as double);
    });

    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((t) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: t["day"].toString(),
                value: double.parse(t["value"].toString()),
                percentage: maxAmountInWeek == 0.0
                    ? 0.0
                    : (t["value"] as double) / maxAmountInWeek,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
