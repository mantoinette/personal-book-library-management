import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_provider.dart';
import 'sorting_provider.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final sortingCriteria = ref.watch(sortingProvider);

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
              value: isDarkMode,
              onChanged: (bool value) {
                ref.read(themeProvider.notifier).toggleTheme();
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
              groupValue: sortingCriteria,
              onChanged: (value) {
                ref.read(sortingProvider.notifier).setSortingCriteria(value as String);
              },
            ),
            RadioListTile(
              title: Text('Author'),
              value: 'author',
              groupValue: sortingCriteria,
              onChanged: (value) {
                ref.read(sortingProvider.notifier).setSortingCriteria(value as String);
              },
            ),
            RadioListTile(
              title: Text('Rating'),
              value: 'rating',
              groupValue: sortingCriteria,
              onChanged: (value) {
                ref.read(sortingProvider.notifier).setSortingCriteria(value as String);
              },
            ),
          ],
        ),
      ),
    );
  }
}
