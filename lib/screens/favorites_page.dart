import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favoriteCourses = provider.courses
        .where((c) => provider.isFavorite(c.code))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kursus Favorit Saya'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: favoriteCourses.isEmpty
          ? const Center(
              child: Text('Belum ada kursus favorit yang ditambahkan.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteCourses.length,
              itemBuilder: (context, index) {
                final course = favoriteCourses[index];
                return CourseCard(
                  course: course,
                  isFavorite: true,
                  onFavoriteToggle: () {
                    context.read<CourseProvider>().toggleFavorite(course.code);
                  },
                );
              },
            ),
    );
  }
}
