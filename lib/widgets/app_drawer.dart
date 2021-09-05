import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/user_account_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2.0,
      child: Column(
        children: [
          AppBar(
            title: Text('Hello!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.userCircle,
              color: Colors.white,
              size: 17,
            ),
            title: Text(
              'GOTC Accounts',
              style: Theme.of(context).accentTextTheme.headline6,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.edit,
              color: Colors.white,
              size: 17,
            ),
            title: Text(
              'Manage Accounts',
              style: Theme.of(context).accentTextTheme.headline6,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserAccountScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
              size: 17,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).accentTextTheme.headline6,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
