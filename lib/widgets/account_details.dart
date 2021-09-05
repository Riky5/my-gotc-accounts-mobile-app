import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/image_avatar.dart';
import '../providers/accounts_provider.dart';

class AccountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedAccount =
        Provider.of<AccountsProvider>(context, listen: false)
            .findById(accountId);
    final fN = intl.NumberFormat("###,###,###,##0");
    return Card(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: ImageAvatar(),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(15),
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2),
                    color: Theme.of(context).primaryColorDark,
                    child: FaIcon(
                      FontAwesomeIcons.coins,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Gold:',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '${fN.format(selectedAccount.gold)}',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ), // ICON FOR GOLD AND GOLD AMOUNT
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2),
                    color: Theme.of(context).primaryColorDark,
                    child: FaIcon(
                      FontAwesomeIcons.seedling,
                      color: Colors.amber.shade300,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Unboxed food:',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '${fN.format(selectedAccount.food)}',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ), // ICON FOR FOOD AND FOOD AMOUNT
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2),
                    color: Theme.of(context).backgroundColor,
                    child: FaIcon(
                      FontAwesomeIcons.tree,
                      color: Colors.brown,
                      size: 23,
                    ),
                  ),
                  title: Text(
                    'Unboxed Wood:',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '${fN.format(selectedAccount.wood)}',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ), // ICON FOR WOOD AND wOOD AMOUNT
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2),
                    color: Theme.of(context).primaryColorDark,
                    child: FaIcon(
                      FontAwesomeIcons.mountain,
                      color: Colors.grey.shade300,
                      size: 15,
                    ),
                  ),
                  title: Text(
                    'Unboxed Stone:',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '${fN.format(selectedAccount.stone)}',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ), // ICON FOR STONE AND STONE AMOUNT
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(2),
                    color: Theme.of(context).backgroundColor,
                    child: FaIcon(
                      FontAwesomeIcons.box,
                      color: Colors.blueGrey,
                      size: 19,
                    ),
                  ),
                  title: Text(
                    'Unboxed Iron:',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '${fN.format(selectedAccount.iron)}',
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
