import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Account with ChangeNotifier {
  final String? id;
  final String name;
  final int gold;
  final int food;
  final int wood;
  final int stone;
  final int iron;
  late bool isFavourite;

  Account({
    this.id,
    this.name = '',
    this.gold = 0,
    this.food = 0,
    this.wood = 0,
    this.stone = 0,
    this.iron = 0,
    this.isFavourite = false,
  });

  void _setFaveValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteAccounts() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-course-5-default-rtdb.europe-west1.firebasedatabase.app/account/$id.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFaveValue(oldStatus);
      }
    } catch (error) {
      _setFaveValue(oldStatus);
    }
  }
}
