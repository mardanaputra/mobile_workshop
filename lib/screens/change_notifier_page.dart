import 'package:flutter/material.dart';

import '../providers/course_provider.dart';
import '../repositories/course_repository.dart';
import '../services/course_service.dart';

import '../services/course_api_service.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({super.key});

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  // Instansiasi CourseProvider dengan mengalirkan Repository dan Service
  final CourseProvider _courseState = CourseProvider(
    CourseRepository(CourseApiService('https://jsonplaceholder.typicode.com')),
  );

  @override
  void dispose() {
    _courseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 5 - ChangeNotifier'),
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
                    // ListenableBuilder mendengarkan notifyListeners() dari _courseState
                    ListenableBuilder(
                      listenable: _courseState,
                      builder: (context, child) {
                        return Chip(
                          avatar: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                          label: Text(
                            '${_courseState.favorites.length} Favorit',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: _courseState,
              builder: (context, child) {
                final courses = [
                  {'code': 'MOB01', 'title': 'Dart Fundamentals'},
                  {'code': 'MOB02', 'title': 'Flutter UI Dasar'},
                  {'code': 'MOB03', 'title': 'State Management'},
                ];

                return Column(
                  children: courses.map((course) {
                    final code = course['code']!;
                    final isFav = _courseState.isFavorite(code);
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
                          onPressed: () => _courseState.toggleFavorite(code),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
