import 'package:flutter/material.dart';

import '../models/course.dart';

import '../widgets/edit_course_dialog.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
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
              label: Text(course.status, style: const TextStyle(fontSize: 12)),
              backgroundColor: course.status == 'done'
                  ? Colors.green.shade100
                  : Colors.amber.shade100,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => EditCourseDialog(course: course),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
