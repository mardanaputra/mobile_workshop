import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/add_course_dialog.dart'; // Import dialog tambah course
import '../widgets/course_card.dart';
import '../widgets/error_view.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil instance CourseProvider secara reaktif
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Course Data Manager')),
      body: _buildBody(context, provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddCourseDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Fungsi terpisah untuk mengelola 4 Kondisi UI
  Widget _buildBody(BuildContext context, CourseProvider provider) {
    // KONDISI 1: Loading State
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // KONDISI 2: Error State
    if (provider.error != null) {
      return ErrorView(message: provider.error!, onRetry: provider.loadCourses);
    }

    // KONDISI 3: Empty State
    if (provider.courses.isEmpty) {
      return const Center(
        child: Text(
          'Data course belum tersedia',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // KONDISI 4: Success State (Menampilkan Daftar Data)
    return RefreshIndicator(
      onRefresh: provider.loadCourses,
      child: ListView.builder(
        itemCount: provider.courses.length,
        itemBuilder: (context, index) {
          final course = provider.courses[index];
          return CourseCard(
            course: course,
            isFavorite: provider.isFavorite(course.code),
            onFavoriteToggle: () => provider.toggleFavorite(course.code),
          );
        },
      ),
    );
  }
}
