import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  // Only App will support only potrait mode
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple, //primary color
        accentColor: Colors.amber, //alternative color
        //errorColor: Colors.red,   => by default it is red only
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
              button: TextStyle(color: Colors.white),
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
  // decide whether to show chart or not
  bool _showChart = false; 
  final List<Transaction> _userTransactions = [
    //Transaction(id: '2', amount: 10, date: DateTime.now(), title: 'Drinks'),
  ];

  // Add new transaction to transaction lists
  void _addNewTransaction(
    String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    //render newly added transaction on UI
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //Remove transaction from transaction lists
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  // Initiate Pop up Modal to take inputs for new transaction
  void _startNewTransactionProcess(BuildContext ctxt) {
    // Pop up new modal sheet from bottom | Modal sheet have fixed height
    showModalBottomSheet(
      context: ctxt,
      builder: (_) {
        // It will close only when tap is outside it's area i.e background
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          // On Tapping the area of popup modal, it will not close.
          onTap: () {},
          //behaviour -> will catch the event & avoid the tap, catch the tap event & avoid if it's handle by anyone else
          behavior: HitTestBehavior.opaque,
          //Avoid sheet closes when tap on sheet
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    //Only transactions that are younger than 7 days are included here
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // mediaQuery is gonna change on every build, but within a single build it's remain intact
    final mediaQuery = MediaQuery.of(context);

    //We are not changing appBar Once building the app so final
    //object for AppBar is ceated so that appBar object has info abt height of AppBar
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTransactionProcess(context),
        ),
      ],
    );

    //get the height value covered by status bar , which is implicitly assigned by Flutter itlself
    final statusBarHeight = mediaQuery.padding.top;

    // check if current orientation is landscope or not
    final isLandScapeMode = mediaQuery.orientation == Orientation.landscape;

    //Transactions List | Take 70% of Screen excluding AppBar size & status bar size
    final txListWidget = Container(
      //Take 70% height of screen left after neglecting appBar height & status bar height
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              statusBarHeight) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      //ScrollView on Parent is required inorder to use scroll view for child
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Switch
            if (isLandScapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandScapeMode) ...[
              //Bar Chart | Take 30% of Screen excluding AppBar size & status bar size in potrait mode
              Container(
                //Take 30% height of screen left after neglectign appBar height & status bar height in Potrait mode
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        statusBarHeight) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
              txListWidget,
            ] else
              _showChart  // Landscape Mode
                  ?
                  //Bar Chart | Take 70% of Screen excluding AppBar size & status bar size in landscape mode
                  Container(
                      //Take 70% height of screen left after neglecting appBar height & status bar height in landscape mode
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              statusBarHeight) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
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
