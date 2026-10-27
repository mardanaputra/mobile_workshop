import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class RepositoryDemoPage extends StatelessWidget {
  const RepositoryDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 10 - Repository Pattern'),
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
              'Daftar Kursus (Provider -> Repository -> Service):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: provider.courses.map((course) {
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
