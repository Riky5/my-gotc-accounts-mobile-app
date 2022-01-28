import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account.dart';
import '../providers/accounts_provider.dart';
import '../widgets/image_selection.dart';

class EditAccountsScreen extends StatefulWidget {
  static const routeName = '/edit_account';

  @override
  _EditAccountsScreenState createState() => _EditAccountsScreenState();
}

class _EditAccountsScreenState extends State<EditAccountsScreen> {
  final _goldFocusNode = FocusNode();
  final _foodFocusNode = FocusNode();
  final _woodFocusNode = FocusNode();
  final _stoneFocusNode = FocusNode();
  final _ironFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedAccount = Account(
    id: null,
    name: '',
    gold: 0,
    food: 0,
    wood: 0,
    stone: 0,
    iron: 0,
  );
  var _initValues = {
    'name': '',
    'gold': '',
    'food': '',
    'wood': '',
    'stone': '',
    'iron': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final accountId = ModalRoute.of(context)!.settings.arguments as String?;
      if (accountId != null) {
        _editedAccount = Provider.of<AccountsProvider>(context, listen: false)
            .findById(accountId);
        _initValues = {
          'name': _editedAccount.name,
          'gold': _editedAccount.gold.toString(),
          'food': _editedAccount.food.toString(),
          'wood': _editedAccount.wood.toString(),
          'stone': _editedAccount.stone.toString(),
          'iron': _editedAccount.iron.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _goldFocusNode.dispose();
    _foodFocusNode.dispose();
    _woodFocusNode.dispose();
    _stoneFocusNode.dispose();
    _ironFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedAccount.id != null) {
      await Provider.of<AccountsProvider>(context, listen: false)
          .updateAccount(_editedAccount.id!, _editedAccount);
    } else {
      try {
        await Provider.of<AccountsProvider>(context, listen: false)
            .addAccount(_editedAccount);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred'),
            content: Text('Something went wrong :('),
            actions: [
              TextButton(
                onPressed: () {
                  Provider.of(ctx).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
        title: Text('Edit Account'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Theme.of(context).primaryColorLight,
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Account Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_goldFocusNode);
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          name: value!,
                          gold: _editedAccount.gold,
                          food: _editedAccount.food,
                          wood: _editedAccount.wood,
                          stone: _editedAccount.stone,
                          iron: _editedAccount.iron,
                          isFavourite: _editedAccount.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['gold'],
                      decoration: InputDecoration(labelText: 'Gold Amount'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _goldFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_foodFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an amount.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter an amount greater than zero.';
                        }
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          name: _editedAccount.name,
                          gold: int.parse(value!),
                          food: _editedAccount.food,
                          wood: _editedAccount.wood,
                          stone: _editedAccount.stone,
                          iron: _editedAccount.iron,
                          isFavourite: _editedAccount.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['food'],
                      decoration: InputDecoration(labelText: 'Food Amount'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_woodFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an amount.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter an amount greater than zero.';
                        }
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          name: _editedAccount.name,
                          gold: _editedAccount.gold,
                          food: int.parse(value!),
                          wood: _editedAccount.wood,
                          stone: _editedAccount.stone,
                          iron: _editedAccount.iron,
                          isFavourite: _editedAccount.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['wood'],
                      decoration: InputDecoration(labelText: 'Wood Amount'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_stoneFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an amount.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter an amount greater than zero.';
                        }
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          name: _editedAccount.name,
                          gold: _editedAccount.gold,
                          food: _editedAccount.food,
                          wood: int.parse(value!),
                          stone: _editedAccount.stone,
                          iron: _editedAccount.iron,
                          isFavourite: _editedAccount.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['stone'],
                      decoration: InputDecoration(labelText: 'Stone Amount'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ironFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an amount.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter an amount greater than zero.';
                        }
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          name: _editedAccount.name,
                          gold: _editedAccount.gold,
                          food: _editedAccount.food,
                          wood: _editedAccount.wood,
                          stone: int.parse(value!),
                          iron: _editedAccount.iron,
                          isFavourite: _editedAccount.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['iron'],
                      decoration: InputDecoration(labelText: 'Iron Amount'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // onFieldSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus();
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an amount.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter an amount greater than zero.';
                        }
                      },
                      onSaved: (value) {
                        _editedAccount = Account(
                          id: _editedAccount.id,
                          name: _editedAccount.name,
                          gold: _editedAccount.gold,
                          food: _editedAccount.food,
                          wood: _editedAccount.wood,
                          stone: _editedAccount.stone,
                          iron: int.parse(value!),
                          isFavourite: _editedAccount.isFavourite,
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      padding: EdgeInsets.all(5),
                      height: 200,
                      child: GestureDetector(
                        onTap: () {},
                        child: ImageSelection(),
                      ),
                    ),
                    // width: 100,
                    // height: 100,
                    // margin: EdgeInsets.all(5),
                    // child: PickedImage(),
                    // Image.asset('images/girl_avatar.jpg'),
                    // MODIFY LATER - DUMMY ATM
                    TextButton(
                      child: Text('SAVE'),
                      onPressed: _saveForm,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
