import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/routes/home/profile/profilePage.dart';
import 'package:fitnet/routes/home/workout/workoutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/tabScreen/tabScreen.dart';
import '../authChangeNotifier.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/logo-white-2.png'),
            ),
          ),
        ),
      ),
      body: ProxyProvider<AuthChangeNotifier, AppUser>(
        create: (ctx) => Provider.of<AuthChangeNotifier>(ctx, listen: false).user, 
        update: (_, notifier, __) => notifier.user,
        builder: (_, __) => 
          SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 80,
            child: TabScreen(
              lowerTabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.whatshot_outlined), Text('Workout')],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.person_outline), Text('Profile')],
                  ),
                ),
              ],
              tabPages: [
                WorkoutPage(),
                ProfilePage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
