import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/course.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/main_screen.dart';
import 'services/course_service.dart';

// Identitas Mahasiswa
const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

/// Fungsi Pengujian Tahap 3 (Model Course fromJson & toJson)
void testCourseModel() {
  final Map<String, dynamic> sampleJson = {
    'id': 1,
    'code': 'MOB01',
    'title': 'Git & GitHub',
    'credits': 2,
    'status': 'done',
  };

  // Uji fromJson
  final course = Course.fromJson(sampleJson);

  // Print output persis sesuai format screenshot praktikum
  debugPrint('Nama: $studentName');
  debugPrint('NIM: $studentId');
  debugPrint('Course toJson: ${course.toJson()}');
  debugPrint('Course fromJson: ${course.title}');
  debugPrint('Course code: ${course.code}');
  debugPrint('Course credits: ${course.credits}');
  debugPrint('Course status: ${course.status}');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Panggil pengujian model sebelum runApp
  testCourseModel();

  final courseService = CourseService();
  final courseRepository = CourseRepository(courseService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Data Manager',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const MainScreen(),
    );
  }
}
