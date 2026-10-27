import 'package:flutter/material.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class LiftingStateUpPage extends StatefulWidget {
  const LiftingStateUpPage({super.key});

  @override
  State<LiftingStateUpPage> createState() => _LiftingStateUpPageState();
}

class _LiftingStateUpPageState extends State<LiftingStateUpPage> {
  // Single Source of Truth berada di Parent Widget
  final Set<String> _favoriteCourses = {};

  void _toggleFavorite(String code) {
    setState(() {
      if (_favoriteCourses.contains(code)) {
        _favoriteCourses.remove(code);
      } else {
        _favoriteCourses.add(code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 3 - Lifting State Up'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HeaderSummaryCard(
              studentName: studentName,
              studentId: studentId,
              favoriteCount: _favoriteCourses.length,
            ),
            const SizedBox(height: 12),
            FavoritesOverviewCard(favorites: _favoriteCourses),
            const SizedBox(height: 16),
            CourseCard(
              code: 'MOB01',
              title: 'Dart Fundamentals',
              isFavorite: _favoriteCourses.contains('MOB01'),
              onFavoriteChanged: () => _toggleFavorite('MOB01'),
            ),
            CourseCard(
              code: 'MOB02',
              title: 'Flutter UI Dasar',
              isFavorite: _favoriteCourses.contains('MOB02'),
              onFavoriteChanged: () => _toggleFavorite('MOB02'),
            ),
            CourseCard(
              code: 'MOB03',
              title: 'State Management',
              isFavorite: _favoriteCourses.contains('MOB03'),
              onFavoriteChanged: () => _toggleFavorite('MOB03'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Child 1: Menampilkan list kursus & pemicu callback
class CourseCard extends StatelessWidget {
  final String code;
  final String title;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteChanged,
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
          onPressed: onFavoriteChanged,
        ),
      ),
    );
  }
}

// Widget Child 2: Ringkasan Header
class HeaderSummaryCard extends StatelessWidget {
  final String studentName;
  final String studentId;
  final int favoriteCount;

  const HeaderSummaryCard({
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
            const Icon(Icons.person, size: 36, color: Colors.blue),
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

// Widget Child 3: Menampilkan daftar kode favorit aktif
class FavoritesOverviewCard extends StatelessWidget {
  final Set<String> favorites;

  const FavoritesOverviewCard({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                favorites.isEmpty
                    ? 'Belum ada favorit'
                    : 'Favorit Aktif: ${favorites.join(", ")}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
