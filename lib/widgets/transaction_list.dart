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
                    fit: BoxFit
                        .cover, // this makes image to fit to it's surrounding
                  ),
                ), //Image need container as a parent inorder to fit appropriate otherwise it will not fit to column as column takes as much height as it got
              ],
            )
          : ListView.builder(
              itemBuilder: (ctxt, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            // give reference/tunnel to theme data; define in MateriaApp
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          // Display the amount in always 2 decimal places
                          '\$${transactions[index].amount.toStringAsFixed(2)}', 
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        //Aligning All details on left side
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Title
                          Text(
                            transactions[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .title, // fetching style from global style define in MaterialApp
                          ),
                          // Date
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
