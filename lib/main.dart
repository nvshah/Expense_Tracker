import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple, //primary color
        accentColor: Colors.amber, //alternative color
        fontFamily: 'Quicksand',
        //Don't override all text but title that is marked in AppBar by flutter
        appBarTheme: AppBarTheme(
          //Copy default text settings i.e font size, & all but with different style specific for title under Appbar
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        //global theme for text in app / independent from appbar
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
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
    //Transaction(id: '2', amount: 10, date: DateTime.now(), title: 'Drinks'),
  ];

  // Add new transaction to transaction lists
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    //render newly added transaction on UI
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  // Initiate Pop up Modal to take inputs for new transaction
  void _startNewTransactionProcess(BuildContext ctxt) {
    showModalBottomSheet(
      context: ctxt,
      builder: (_) {
        // It will close only when tap is outside it's area i.e background
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap:() {}, // On Tapping the area of popup modal, it will not close.
          behavior: HitTestBehavior.opaque, //behaviour -> will catch the event & avoid the tap, catch the tap event & avoid if it's handle by anyone else
          //Avoid sheet closes when tap on sheet
        );
      },
    );
  }

  List<Transaction> get _recentTransactions{
    //Only transactions that are younger than 7 days are included here
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7,)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
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
            Chart(_recentTransactions),
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
