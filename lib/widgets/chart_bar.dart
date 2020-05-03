import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingContribution;

  ChartBar(this.label, this.spendingAmount, this.spendingContribution);
  @override
  Widget build(BuildContext context) {
    //Single bar in standing in row
    return Column(
      children: <Widget>[
        // Prevents that this Text keep it's original size | You will not grwo in anyway | Shrinkt to fit into the box
        // Avoid line breaks due to larget text
        Container(
          //required inorder to ensure that ChartBar & Textbelow chartBar are aligned on same axis when text of FittedBox shrinks
          height: 20,
          child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        // Seperator | 4 pixels gap
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              // This will take height as same of parent container i.e 60 pixel
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              //This will take fractional height equal to percentage provided
              FractionallySizedBox(
                heightFactor: spendingContribution,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        // Seperator | 4 pixels gap
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
