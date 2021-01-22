import '../../utils/customColors.dart';
import '../../shared/tabScreen/tabScreen.dart';
import 'loginPage.dart';
import 'signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: CustomColors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo-white-2.png'),
                  ),
                ),
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: TabScreen(
                    upperTabs: [
                      Tab(
                        child: Text(
                          'Log In',
                          style: TextStyle(color: CustomColors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: CustomColors.black),
                        ),
                      ),
                    ],
                    tabPages: [LoginPage(), SignUpPage()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
