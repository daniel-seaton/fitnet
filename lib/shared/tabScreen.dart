import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/customColors.dart';

class TabScreen extends StatelessWidget {
  final List<Tab> upperTabs = [];
  final List<Tab> lowerTabs = [];
  final List<Widget> tabPages = [];
  int numTabs;

  TabScreen({List<Tab> upperTabs, List<Tab> lowerTabs, List<Widget> tabPages}) {
    if (upperTabs != null) this.upperTabs.addAll(upperTabs);
    if (lowerTabs != null) this.lowerTabs.addAll(lowerTabs);
    if (tabPages != null) {
      this.tabPages.addAll(tabPages);
      this.numTabs = tabPages.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: numTabs,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: upperTabs.length > 0
              ? Container(height: 50, child: TabBar(tabs: upperTabs))
              : Container(height: 0, width: 0),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height - 50,
          child: TabBarView(children: tabPages),
        ),
        bottomNavigationBar: Material(
            color: CustomColors.blue,
            child: lowerTabs.length > 0
                ? TabBar(tabs: lowerTabs)
                : Container(
                    height: 0,
                    width: 0,
                  )),
      ),
    );
  }
}
