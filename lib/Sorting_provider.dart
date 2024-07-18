// sorting_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sortingProvider = StateNotifierProvider<SortingNotifier, String>((ref) => SortingNotifier());

class SortingNotifier extends StateNotifier<String> {
  SortingNotifier() : super('title') {
    _loadSortingCriteria();
  }

  void setSortingCriteria(String criteria) async {
    state = criteria;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sortingCriteria', state);
  }

  void _loadSortingCriteria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getString('sortingCriteria') ?? 'title';
  }
}
