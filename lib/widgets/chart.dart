import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      //total amount spent on weekDay
      var totalSum = 0.0;
      // As 2 DateTime Object can never be same, we need to compare day, month & year inorder to find amount spent per day
      recentTransactions.forEach((transaction) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == transaction.date.year)
          totalSum += transaction.amount;
      });
      //Getonly first character of week day
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  // calculate total spending happened in last 7 days
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, data) {
      return sum + data['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          //Require some space between ChartBar & Card border to have some good appearance
          padding: EdgeInsets.all(10),
          child: Row(
            children: groupedTransactionValues.map((data) {
              return Flexible(
                //don't allow ChartBar to grow & take size of it's sibbling ChartBar
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ));
  }
}
