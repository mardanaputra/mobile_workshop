import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class ModelCoursePage extends StatelessWidget {
  const ModelCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulasi data JSON mentah sebelum memisahkan ke Service di Tahap 9
    final List<Map<String, dynamic>> rawJsonList = [
      {
        'code': 'MOB01',
        'title': 'Dart Fundamentals',
        'credits': 3,
        'status': 'done',
      },
      {
        'code': 'MOB02',
        'title': 'Flutter UI Dasar',
        'credits': 4,
        'status': 'done',
      },
      {
        'code': 'MOB03',
        'title': 'State Management',
        'credits': 3,
        'status': 'active',
      },
    ];

    // Parsing Map<String, dynamic> menjadi List<Course> via Course.fromJson
    final List<Course> courseList = rawJsonList
        .map((json) => Course.fromJson(json))
        .toList();

    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 8 - Model Course'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      label: Text('${provider.favorites.length} Favorit'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Daftar Kursus (Parsed via Model Course):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Column(
              children: courseList.map((course) {
                final isFav = provider.isFavorite(course.code);
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(
                      course.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${course.code} • ${course.credits} SKS'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(
                          label: Text(
                            course.status,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: course.status == 'done'
                              ? Colors.green.shade100
                              : Colors.amber.shade100,
                        ),
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            context.read<CourseProvider>().toggleFavorite(
                              course.code,
                            );
                          },
                        ),
                      ],
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
