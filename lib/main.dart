import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '2', amount: 10, date: DateTime.now(), title: 'Drinks'),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }
  
  // Pop up Modal to take inputs for new transaction 
  void _startNewTransactionProcess(BuildContext ctxt) {
    showModalBottomSheet(
      context: ctxt,
      builder: (_) {
        // It will close only when tap is outside it's area i.e background
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},   // On Tapping the area of popup modal, it will not close.
          behavior: HitTestBehavior.opaque,  //behaviour -> will catch the event & avoid the tap, catch the tap event & avoid if it's handle by anyone else
          //Avoid sheet closes when tap on sheet
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Application'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTransactionProcess(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransactionProcess(context),
      ),
    );
  }
}
