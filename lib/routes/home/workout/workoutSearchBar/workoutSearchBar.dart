import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/customColors.dart';
import '../filterChangeNotifier.dart';

class WorkoutSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 2), blurRadius: 3, color: CustomColors.darkGrey)
      ], color: CustomColors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: CustomColors.grey,
            size: 30.0,
          ),
          Expanded(
            child: Consumer<FilterChangeNotifier>(
              builder: (_, notifier, __) => TextField(
                onSubmitted: (value) {
                  notifier.setFilter(value);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: CustomColors.lightGrey,
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: CustomColors.lightGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: CustomColors.lightGrey),
                  ),
                ),
                style: TextStyle(color: CustomColors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
