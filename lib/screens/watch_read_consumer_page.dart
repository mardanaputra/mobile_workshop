import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class WatchReadConsumerPage extends StatelessWidget {
  const WatchReadConsumerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. context.watch() mendaftarkan listener untuk merebuild seluruh UI halaman ini saat state berubah
    final favoriteCount = context.watch<CourseProvider>().favorites.length;

    final courses = [
      {'code': 'MOB01', 'title': 'Dart Fundamentals'},
      {'code': 'MOB02', 'title': 'Flutter UI Dasar'},
      {'code': 'MOB03', 'title': 'State Management'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 7 - watch vs read vs Consumer'),
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
                      label: Text('$favoriteCount Favorit'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 2. Consumer membatasi area rebuild hanya pada Widget Card ini
            Consumer<CourseProvider>(
              builder: (context, provider, child) {
                return Card(
                  color: Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Consumer Rebuild Terisolasi: ${provider.favorites.length} kursus dipilih',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Column(
              children: courses.map((course) {
                final code = course['code']!;
                final isFav = context.watch<CourseProvider>().isFavorite(code);
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
                      // 3. context.read() dipanggil di event handler untuk mengeksekusi method tanpa mendaftarkan listener
                      onPressed: () {
                        context.read<CourseProvider>().toggleFavorite(code);
                      },
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
