import 'package:flutter/material.dart';

//Converted to State ful Widget inorder to avoid loosing of inputs entered in Modal Sheet 
// this will hold the inputs, as state is being handled diff than Widget & so state is maintained 
class NewTransaction extends StatefulWidget {
  //Properties
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  
  // submit transaction data to Denominator/Parent class & so list of transactions get updated
  void sendData() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);

    //if any input field is invalid
    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }
    // Add transaction to transactions List
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );
    //close modal sheet when input's completed & transaction added to transaction list; come back to main screen
    //context here gives you context of widget
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => sendData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => sendData(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purpleAccent,
              onPressed: sendData,
            ),
          ],
        ),
      ),
    );
  }
}
