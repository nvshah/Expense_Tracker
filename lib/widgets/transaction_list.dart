import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet.. !',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ), // Act as a seperator between Text & Image container
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    // this makes image to fit to it's surrounding
                    fit: BoxFit.cover,
                  ),
                ), //Image need container as a parent inorder to fit appropriate otherwise it will not fit to column as column takes as much height as it got
              ],
            )
          : ListView.builder(
              itemBuilder: (ctxt, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: FittedBox(
                          // Amount | Display the amount in always 2 decimal places
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    //Title
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    //Date
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
