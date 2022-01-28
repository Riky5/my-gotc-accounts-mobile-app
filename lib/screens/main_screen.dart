import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_accounts_screen.dart';
import '../widgets/account_grid.dart';
import '../widgets/app_drawer.dart';
import '../providers/accounts_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  var _isLoading = false;

  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<AccountsProvider>(context, listen: false)
    //       .fetchAndSetAccounts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AccountsProvider>(context, listen: false)
          .fetchAndSetAccounts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('building main screen');
    final appBar = AppBar(
      title: Text(
        'My GOTC Accounts:',
        style: Theme.of(context).accentTextTheme.headline6,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditAccountsScreen.routeName);
          },
          tooltip: 'Add New Account',
          icon: Icon(
            Icons.add,
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        1,
                    child: AccountGrid(),
                  ),
                ],
              ),
            ),
    );
  }
}
