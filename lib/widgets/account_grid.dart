import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts_provider.dart';
import '../widgets/account_item.dart';

class AccountGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountData = Provider.of<AccountsProvider>(context);
    final accounts = accountData.items;
    return accounts.isEmpty
        ? ListView(
            padding: EdgeInsets.all(15),
            children: [
              SizedBox(
                height: 30,
                child: Text(
                  'No Accounts Added Yet!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Image.asset(
                'images/gotc_loading.PNG',
                fit: BoxFit.cover,
              )
            ],
          )
        : Container(
            padding: EdgeInsets.all(5),
            color: Theme.of(context).primaryColorLight,
            child: GridView.builder(
              itemCount: accounts.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                // create: (c) => account[i],
                value: accounts[i], //value constructor for lists
                child: AccountItem(),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.13,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
            ),
          );
  }
}
