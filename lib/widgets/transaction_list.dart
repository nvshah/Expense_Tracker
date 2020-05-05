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
                  SizedBox(
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
                  //Delete transaction button | If device has sufficient size the label along with icon will be shown
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        )
                      : IconButton(
                          //trash Icon
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
