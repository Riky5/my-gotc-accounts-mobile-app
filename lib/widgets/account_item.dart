import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/image_avatar.dart';
import '../screens/account_details_screen.dart';
import '../providers/account.dart';

class AccountItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedAccount = Provider.of<Account>(context);
    final formatted = intl.NumberFormat.compact().format(loadedAccount.gold);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AccountDetailsScreen.routeName,
            arguments: loadedAccount.id,
          ); //to NAVIGATE TO THE ACCOUNT DETAIL SCREEN
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 25,
                  ),
                  child: ImageAvatar(),
                ),
                Positioned(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(2),
                    child: Text(
                      loadedAccount.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).accentTextTheme.headline6,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  width: 200,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      // borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: FaIcon(
                            FontAwesomeIcons.coins,
                            color: Colors.amber.shade600,
                            size: 17,
                          ), //Icon reppresenting Gold
                        ),
                        Text(
                          formatted.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ), // Gold Amount
                        ),
                        Consumer<Account>(
                          builder: (ctx, account, child) => IconButton(
                            onPressed: loadedAccount.toggleFavouriteAccounts,
                            icon: Icon(
                              account.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Theme.of(context).accentColor,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
