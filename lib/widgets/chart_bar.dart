import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spendingAmount;
  final double spendingContribution;
  final String label;

  ChartBar(this.label, this.spendingAmount, this.spendingContribution);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctxt, constraints) {
        //Single bar in standing in row
        return Column(
          children: <Widget>[
            //Total Price text
            Container(
              // Reserved the 15% of height the entire bar can take for the Total price text
              height: constraints.maxHeight * 0.15,
              //let allow the text to fit in the box if screen size decreases
              // Prevents that this Text keep it's original size | You will not grow in anyway | Shrinkt to fit into the box
              // Avoid line breaks due to larget text
              //required inorder to ensure that ChartBar & Textbelow chartBar are aligned on same axis when text of FittedBox shrinks
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            // Seperator | 4 pixels gap
            SizedBox(
              // Reserved the 5% of height of the entire bar for the inbetween seperation space
              height: constraints.maxHeight * 0.05,
            ),
            //bar which displays the contributing percentage overall Week
            Container(
              // Bar will take 60% of height avialable for entire chart bar
              height: constraints.maxHeight * 0.6,
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
              // Reserved the 5% of height of the entire bar for the inbetween seperation space
              height: constraints.maxHeight * 0.05,
            ),
            //WeekDay Label
            Container(
              // WeekDay label will consume 15% of height avaialble for the entire chart-bar
              height: constraints.maxHeight * 0.15,
              // To accomodate label text in small device or if small heights available
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
