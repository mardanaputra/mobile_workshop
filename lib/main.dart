import 'package:flutter/material.dart';

// Identitas Mahasiswa sesuai ketentuan worksheet
const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer - Tahap 12',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const InteractionCoursePage(),
    );
  }
}

// Model data kursus sederhana dengan state isFavorite
class CourseItem {
  final String title;
  final String code;
  final String credits;
  bool isFavorite;

  CourseItem({
    required this.title,
    required this.code,
    required this.credits,
    this.isFavorite = false,
  });
}

class InteractionCoursePage extends StatefulWidget {
  const InteractionCoursePage({super.key});

  @override
  State<InteractionCoursePage> createState() => _InteractionCoursePageState();
}

class _InteractionCoursePageState extends State<InteractionCoursePage> {
  // Daftar data interaktif
  final List<CourseItem> _courses = [
    CourseItem(title: 'Responsive Layout', code: 'MOB04', credits: '3 SKS'),
    CourseItem(title: 'Navigation', code: 'MOB05', credits: '2 SKS'),
    CourseItem(title: 'User Interaction', code: 'MOB06', credits: '3 SKS'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Interaction'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Identitas Mahasiswa
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.blue.shade50,
            child: const Text(
              'Praktikan: $studentId - $studentName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Petunjuk: Tap kartu (ripple), tekan ikon bintang (favorite), atau tekan lama/long press untuk info.',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.antiAlias, // Agar efek InkWell ripple terpotong rapi mengikuti radius Card
                  child: InkWell(
                    // 1. Aksi Tap Biasa
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Membuka materi: ${course.title}'),
                          duration: const Duration(milliseconds: 900),
                        ),
                      );
                    },
                    // 2. Gesture Long Press (Gesture tambahan)
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(course.title),
                          content: Text(
                            'Informasi Mata Kuliah:\nKode: ${course.code}\nBeban: ${course.credits}\nPraktikan: $studentName ($studentId)',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Tutup'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: const Icon(
                              Icons.menu_book,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${course.code} • ${course.credits}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          // 3. Tombol Favorite dengan State Boolean & Perubahan Ikon
                          IconButton(
                            icon: Icon(
                              course.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: course.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            tooltip: 'Favorite',
                            onPressed: () {
                              setState(() {
                                course.isFavorite = !course.isFavorite;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    course.isFavorite
                                        ? '${course.title} ditambahkan ke favorit'
                                        : '${course.title} dihapus dari favorit',
                                  ),
                                  duration: const Duration(milliseconds: 800),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
