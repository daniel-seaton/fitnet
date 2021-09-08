import 'package:fitnet/models/appUser.dart';
import 'package:fitnet/routes/home/profile/infoWidgetProvider.dart';
import 'package:fitnet/services/authService.dart';
import 'package:fitnet/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../serviceInjector.dart';
import '../../authChangeNotifier.dart';
import 'infoScreenSelector/infoScreenSelector.dart';

class ProfilePage extends StatelessWidget {
  final AuthService authService = injector<AuthService>();
  final UserService userService = injector<UserService>();
  final InfoWidgetProvider widgetProvider = InfoWidgetProvider();

  ProfilePage();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<AuthChangeNotifier, AppUser>(
          create: (ctx) => Provider.of<AuthChangeNotifier>(ctx, listen: false).user, 
          update: (_, notifier, __) => notifier.user
        ),
        ChangeNotifierProvider.value(value: widgetProvider)
      ],
      child: Consumer<AppUser>(
        builder: (_, user, __) => user == null
            ? Center(child: Text('Loading...'))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: InfoScreenSelector()),
                  Spacer(),
                  Expanded(
                    flex: 10,
                    child: Consumer<InfoWidgetProvider>(
                      builder: (_, provider, child) =>
                          provider != null && provider.selectedWidget != null
                              ? provider.selectedWidget
                              : child,
                      child: Center(
                        child: Text('Loading'),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
