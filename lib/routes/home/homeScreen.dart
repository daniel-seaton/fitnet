import 'package:fitnet/routes/home/profile/profilePage.dart';
import 'package:fitnet/routes/home/workout/workoutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/tabScreen/tabScreen.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  HomeScreen({@required this.userId});

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
      body: SingleChildScrollView(
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
              WorkoutPage(userId: userId),
              ProfilePage(userId: userId)
            ],
          ),
        ),
      ),
    );
  }
}
