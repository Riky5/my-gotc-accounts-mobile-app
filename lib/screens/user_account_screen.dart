import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts_provider.dart';
import '../widgets/user_account_item.dart';
import '../widgets/app_drawer.dart';

class UserAccountScreen extends StatelessWidget {
  static const routeName = '/user_accounts';

  @override
  Widget build(BuildContext context) {
    final accountData = Provider.of<AccountsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Accounts',
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              UserAccountItem(
                accountData.items[i].id!,
                accountData.items[i].name,
              ),
              Divider(),
            ],
          ),
          itemCount: accountData.items.length,
        ),
      ),
    );
  }
}
