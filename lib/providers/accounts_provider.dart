import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/account.dart';

class AccountsProvider with ChangeNotifier {
  List<Account> _items = [
    // Account(
    //   id: 'n1',
    //   name: 'Mini World',
    //   gold: 21000,
    //   food: 0,
    //   wood: 0,
    //   stone: 0,
    //   iron: 0,
    // ),
    // Account(
    //   id: 'n2',
    //   name: 'Mini Trip',
    //   gold: 88693,
    //   food: 107113000,
    //   wood: 88308000,
    //   stone: 8316200,
    //   iron: 822200,
    // ),
  ]; //DUMMY DATA;

  List<Account> get items {
    return [..._items];
  } //get a copy

  Account findById(String id) {
    return items.firstWhere((acc) => acc.id == id);
  }

  Future<void> fetchAndSetAccounts() async {
    final url = Uri.parse(
        'https://flutter-course-5-default-rtdb.europe-west1.firebasedatabase.app/account.json');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData;
      extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Account> loadedAccount = [];
      extractedData.forEach((accId, accData) {
        loadedAccount.add(
          Account(
            id: accId,
            name: accData['name'],
            gold: accData['gold'],
            food: accData['food'],
            wood: accData['wood'],
            stone: accData['stone'],
            iron: accData['iron'],
            isFavourite: accData['isFavourite'],
          ),
        );
      });
      _items = loadedAccount;
      notifyListeners();
      // print(json.decode(response.body));
    } catch (error) {
      print(error);
    }
  }

  Future<void> addAccount(Account account) async {
    final url = Uri.parse(
        'https://flutter-course-5-default-rtdb.europe-west1.firebasedatabase.app/account.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': account.name,
          'gold': account.gold,
          'food': account.food,
          'wood': account.wood,
          'stone': account.stone,
          'iron': account.iron,
          'isFavourite': account.isFavourite,
        }),
      );
      final newAccount = Account(
        // id: DateTime.now().toString(),
        id: json.decode(response.body)['name'],
        name: account.name,
        gold: account.gold,
        food: account.food,
        wood: account.wood,
        stone: account.stone,
        iron: account.iron,
      );
      _items.add(newAccount);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateAccount(String id, Account newAccount) async {
    final accIndex = _items.indexWhere((acc) => acc.id == id);
    if (accIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-course-5-default-rtdb.europe-west1.firebasedatabase.app/account/$id.json');
      await http.patch(url,
          body: json.encode({
            'name': newAccount.name,
            'gold': newAccount.gold,
            'food': newAccount.food,
            'wood': newAccount.wood,
            'stone': newAccount.stone,
            'iron': newAccount.iron,
          }));
      _items[accIndex] = newAccount;
      notifyListeners();
    }
  }

  Future<void> deleteAccount(String id) async {
    final url = Uri.parse(
        'https://flutter-course-5-default-rtdb.europe-west1.firebasedatabase.app/account/$id.json');
    final existingAccountIndex = _items.indexWhere((acc) => acc.id == id);
    Account? existingAccount = _items[existingAccountIndex];
    _items.removeAt(existingAccountIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingAccountIndex, existingAccount);
      notifyListeners();
    }
    existingAccount = null;
  }
}
