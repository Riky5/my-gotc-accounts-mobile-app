import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/edit_accounts_screen.dart';
import 'image_avatar.dart';
import '../providers/accounts_provider.dart';

class UserAccountItem extends StatelessWidget {
  final String id;
  final String name;

  UserAccountItem(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ImageAvatar(),
      ),
      title: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditAccountsScreen.routeName,
                  arguments: id,
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.edit,
                color: Theme.of(context).accentColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<AccountsProvider>(context, listen: false)
                    .deleteAccount(id);
              },
              icon: FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
