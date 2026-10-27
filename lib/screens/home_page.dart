import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/student_header_card.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer v2 - Modular'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentHeaderCard(
              studentName: studentName,
              studentId: studentId,
              favoriteCount: provider.favorites.length,
            ),
            const SizedBox(height: 16),
            const Text(
              'Daftar Kursus (Modular Architecture):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.error != null)
              Text('Error: ${provider.error}')
            else
              Column(
                children: provider.courses.map((course) {
                  return CourseCard(
                    course: course,
                    isFavorite: provider.isFavorite(course.code),
                    onFavoriteToggle: () {
                      context.read<CourseProvider>().toggleFavorite(
                        course.code,
                      );
                    },
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
