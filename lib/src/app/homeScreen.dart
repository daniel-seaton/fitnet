import 'package:fitnet/src/app/create/createPage.dart';
import 'package:fitnet/src/app/profile/profilePage.dart';
import 'package:fitnet/src/app/workout/workoutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tabScreen.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  HomeScreen({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/logo-white-2.png'),
              ),
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
                  children: [Icon(Icons.add_circle_outline), Text('Create')],
                ),
              ),
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
              CreatePage(),
              WorkoutPage(),
              ProfilePage(userId: userId)
            ],
          ),
        ),
      ),
    );
  }
}
