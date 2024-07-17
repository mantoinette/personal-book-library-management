
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Sorting_provider.dart';
import 'Sorting_provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final sortingProvider = Provider.of<SortingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                themeProvider.toggleTheme();
              },
            ),
            SizedBox(height: 20),
            Text(
              'Sort Books By',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: Text('Title'),
              value: 'title',
              groupValue: sortingProvider.sortingCriteria,
              onChanged: (value) {
                sortingProvider.setSortingCriteria(value as String);
              },
            ),
            RadioListTile(
              title: Text('Author'),
              value: 'author',
              groupValue: sortingProvider.sortingCriteria,
              onChanged: (value) {
                sortingProvider.setSortingCriteria(value as String);
              },
            ),
            RadioListTile(
              title: Text('Rating'),
              value: 'rating',
              groupValue: sortingProvider.sortingCriteria,
              onChanged: (value) {
                sortingProvider.setSortingCriteria(value as String);
              },
            ),
          ],
        ),
      ),
    );
  }
}
