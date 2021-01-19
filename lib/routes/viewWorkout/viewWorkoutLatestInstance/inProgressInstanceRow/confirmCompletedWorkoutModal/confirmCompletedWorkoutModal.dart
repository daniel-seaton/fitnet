import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

class ConfirmCompleteWorkoutModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: CustomColors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Confirm',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: CustomColors.white),
              ),
            ),
            Text('Are you sure you would like to complete this workout early?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('Confirm',
                      style: TextStyle(color: CustomColors.blue, fontSize: 18)),
                  onPressed: () => {Navigator.of(context).pop(true)},
                ),
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: CustomColors.red, fontSize: 18),
                  ),
                  onPressed: () => {Navigator.of(context).pop(false)},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
