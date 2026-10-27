import 'package:flutter/material.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class ParentStateOwnerPage extends StatefulWidget {
  const ParentStateOwnerPage({super.key});

  @override
  State<ParentStateOwnerPage> createState() => _ParentStateOwnerPageState();
}

class _ParentStateOwnerPageState extends State<ParentStateOwnerPage> {
  // Parent menyimpan Single Source of Truth
  final Set<String> _favoriteCourseCodes = {};

  void _toggleFavorite(String code) {
    setState(() {
      if (_favoriteCourseCodes.contains(code)) {
        _favoriteCourseCodes.remove(code);
      } else {
        _favoriteCourseCodes.add(code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 2 - Keterbatasan setState'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeaderStudentCard(
              studentName: studentName,
              studentId: studentId,
              favoriteCount: _favoriteCourseCodes.length,
            ),
            const SizedBox(height: 16),
            // Pass data & callback secara berantai (Prop Drilling)
            CourseListContainer(
              favorites: _favoriteCourseCodes,
              onToggleFavorite: _toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Perantara (Intermediate Widget)
class CourseListContainer extends StatelessWidget {
  final Set<String> favorites;
  final Function(String) onToggleFavorite;

  const CourseListContainer({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final courses = [
      {'code': 'MOB01', 'title': 'Dart Fundamentals'},
      {'code': 'MOB02', 'title': 'Flutter UI Dasar'},
      {'code': 'MOB03', 'title': 'State Management'},
    ];

    return Column(
      children: courses.map((course) {
        final code = course['code']!;
        final isFav = favorites.contains(code);
        return CourseCardItem(
          code: code,
          title: course['title']!,
          isFavorite: isFav,
          onToggle: () => onToggleFavorite(code),
        );
      }).toList(),
    );
  }
}

// Widget Anak Paling Bawah
class CourseCardItem extends StatelessWidget {
  final String code;
  final String title;
  final bool isFavorite;
  final VoidCallback onToggle;

  const CourseCardItem({
    super.key,
    required this.code,
    required this.title,
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(code),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}

class HeaderStudentCard extends StatelessWidget {
  final String studentName;
  final String studentId;
  final int favoriteCount;

  const HeaderStudentCard({
    super.key,
    required this.studentName,
    required this.studentId,
    required this.favoriteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.person, size: 40, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('NIM: $studentId'),
                ],
              ),
            ),
            Chip(
              avatar: const Icon(Icons.favorite, color: Colors.red, size: 18),
              label: Text('$favoriteCount Favorit'),
            ),
          ],
        ),
      ),
    );
  }
}
