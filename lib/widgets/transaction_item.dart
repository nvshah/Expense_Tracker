import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  //background color for circleAvatar of item
  var _bgColor;

  @override
  void initState() {
    //For CircleAvatar
    const availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];

    //Every Transaction recieves some new background color
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Each Transaction Item
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        //Avatar Amount
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6.0),
            //Fittedbox will try to fit the text in it's original position
            child: FittedBox(
              // Amount | Display the amount in always 2 decimal places
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        //Title
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        //Date
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        //Delete transaction button | If device has sufficient size the label along with icon will be shown
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                //Eliminating redundant object instantiation on rebuild
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              )
            : IconButton(
                //trash Icon
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
