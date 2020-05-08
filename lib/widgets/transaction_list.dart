import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // Bottom container will have fixed 60% of screen height
    return transactions.isEmpty
        // LayoutBuilder use to manage space appropriately & build mainly Row & Column type widget more efficiently
        // Empty Transaction List
        ? LayoutBuilder(
            builder: (ctxt, constraints) {
              return Column(
                children: <Widget>[
                  //Empty Transaction text
                  Text(
                    'No transactions added yet.. !',
                    style: Theme.of(context).textTheme.title,
                  ),
                  // Act as a seperator between Text & Image container
                  const SizedBox(
                    //Seperation will adjust it's height as of 10 % of total Height assigned for transactions list
                    height: 10,
                  ),
                  // Image
                  Container(
                    //Image need container as a parent inorder to fit appropriate otherwise it will not fit to column as column takes as much height as it got
                    //Image will take height dynamically equals to 60% of the available height fot transactions list Widget (custom)
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      // this makes image to fit to it's surrounding
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        //ListView - So that transactions can be scrolled within Container
        : ListView.builder(
            itemBuilder: (ctxt, index) {
              //Each Transaction Card
              return TransactionItem(
                transaction: transactions[index],
                deleteTx: deleteTx,
              );
            },
            itemCount: transactions.length,
          );
  }
}
