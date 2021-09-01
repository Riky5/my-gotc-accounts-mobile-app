import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts_provider.dart';
import '../widgets/account_details.dart';

class AccountDetailsScreen extends StatelessWidget {
  static const routeName = '/account_details';

  @override
  Widget build(BuildContext context) {
    final accountId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedAccount =
        Provider.of<AccountsProvider>(context, listen: false)
            .findById(accountId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedAccount.name),
      ),
      body: Center(
        child: Container(
          child: AccountDetails(),
        ),
      ),
    );
  }
}
