import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class ProviderDemoPage extends StatelessWidget {
  const ProviderDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    final courses = [
      {'code': 'MOB01', 'title': 'Dart Fundamentals'},
      {'code': 'MOB02', 'title': 'Flutter UI Dasar'},
      {'code': 'MOB03', 'title': 'State Management'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 6 - Provider Setup'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 36, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            studentName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('NIM: $studentId'),
                        ],
                      ),
                    ),
                    Chip(
                      avatar: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),
                      label: Text('${courseProvider.favorites.length} Favorit'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: courses.map((course) {
                final code = course['code']!;
                final isFav = courseProvider.isFavorite(code);
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(
                      course['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(code),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => courseProvider.toggleFavorite(code),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
