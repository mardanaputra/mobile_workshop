import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final isFav = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              context.read<CourseProvider>().toggleFavorite(course.code);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kode: ${course.code} | Bobot: ${course.credits} SKS | Status: ${course.status}',
            ),
            const Divider(height: 32),
            Text(
              'Status Favorit: ${isFav ? "Favorit" : "Bukan Favorit"}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isFav ? Colors.red : Colors.grey,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CourseProvider>().toggleFavorite(course.code);
                },
                icon: Icon(isFav ? Icons.favorite_border : Icons.favorite),
                label: Text(isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
