import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // Bottom container will have fixed 60% of screen height
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No transactions added yet.. !',
                style: Theme.of(context).textTheme.title,
              ),
              // Act as a seperator between Text & Image container
              SizedBox(
                height: 10,
              ),
              // Image
              Container(
                //Image need container as a parent inorder to fit appropriate otherwise it will not fit to column as column takes as much height as it got
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  // this makes image to fit to it's surrounding
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        //ListView - So that transactions can be scrolled within Container
        : ListView.builder(
            itemBuilder: (ctxt, index) {
              //Each Transaction Card
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
                  //Delete transaction button
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
