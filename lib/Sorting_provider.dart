
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortingProvider with ChangeNotifier {
  String _sortingCriteria = 'title';

  String get sortingCriteria => _sortingCriteria;

  SortingProvider() {
    _loadSortingCriteria();
  }

  void setSortingCriteria(String criteria) async {
    _sortingCriteria = criteria;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sortingCriteria', _sortingCriteria);
  }

  void _loadSortingCriteria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sortingCriteria = prefs.getString('sortingCriteria') ?? 'title';
    notifyListeners();
  }
}
