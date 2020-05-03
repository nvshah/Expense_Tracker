import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  // submit transaction data to Denominator/Parent class & so list of transactions get updated
  void _sendData() {
    if(_amountController.text.isEmpty){
      return;
    }
    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);
    //if any input field is invalid
    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }
    // Add transaction to transactions List
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    //close modal sheet when input's completed & transaction added to transaction list; come back to main screen
    //context here gives you context of widget
    Navigator.of(context).pop();
  }

  //Display DatePicker
  void _presentDatePicker() {
    //date cannont be slected for future task & also task which are previous to 2019 date
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      //cancel button is clicked
      if (pickedDate == null) {
        return;
      }
      setState(() {
        //After selecting date ok button is clicked
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          //Specifically meant for FlatButton becuase TextField by default will take all size
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //fetch Title
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _sendData(),
            ),
            //fetch Amount
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _sendData(),
            ),
            //Date
            Container(
              //So that there is litlle space seperation between Amount Textfield & Date Section
              height: 70,
              child: Row(
                children: <Widget>[
                  //Text takes all space as much as it can extend
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen !'
                          : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  //date choose button will take as much space as its needs
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            //Add Transaction button
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              //default button color text theme define by dart
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _sendData,
            ),
          ],
        ),
      ),
    );
  }
}
