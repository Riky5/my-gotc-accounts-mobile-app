import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/image_avatar.dart';
import '../screens/account_details_screen.dart';
import '../providers/account.dart';

class AccountItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedAccount = Provider.of<Account>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      shadowColor: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      color: Theme.of(context).primaryColorDark,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AccountDetailsScreen.routeName,
            arguments: loadedAccount.id,
          ); //to NAVIGATE TO THE ACCOUNT DETAIL SCREEN
        },
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageAvatar(),
            ), //IMAGE avatar on the left
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    loadedAccount.name,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                ), //Account Name
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 10,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.coins,
                          color: Colors.amber.shade600,
                          size: 17,
                        ), //Icon reppresenting Gold
                      ),
                      Text(
                        loadedAccount.gold.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ), // Gold Amount
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Consumer<Account>(
              builder: (ctx, account, child) => IconButton(
                onPressed: loadedAccount.toggleFavouriteAccounts,
                icon: Icon(
                  account.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
