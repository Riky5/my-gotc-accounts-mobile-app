import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_accounts_screen.dart';
import '../screens/user_account_screen.dart';
import './screens/account_details_screen.dart';
import './screens/main_screen.dart';
import './providers/accounts_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AccountsProvider(),
      //only rebuild widgets that are listening
      child: MaterialApp(
        title: 'GOTC Account Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.blue,
          accentColor: Colors.pink.shade300,
          accentColorBrightness: Brightness.dark,
          canvasColor: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Cinzel',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'Cinzel',
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                )),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Cinzel',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
        ),
        home: MainScreen(),
        routes: {
          AccountDetailsScreen.routeName: (ctx) => AccountDetailsScreen(),
          UserAccountScreen.routeName: (ctx) => UserAccountScreen(),
          EditAccountsScreen.routeName: (ctx) => EditAccountsScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => MainScreen(),
          );
        },
      ),
    );
  }
}
