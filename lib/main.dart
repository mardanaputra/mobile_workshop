import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/main_screen.dart';
import 'services/course_api_service.dart';
import 'services/course_data_source.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

const String supabaseUrl = 'https://xceedidqnlewiurkggse.supabase.co/rest/v1/';
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhjZWVkaWRxbmxld2l1cmtnZ3NlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMyOTE2NTQsImV4cCI6MjEwODg2NzY1NH0.XaFudn1JeTnI3gwuT0dXVY5291y9yM8QvtqOaxMxHME';

const String apiBaseUrl = 'https://jsonplaceholder.typicode.com';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase Client sebelum runApp
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // Perakitan service -> repository -> provider (masih menggunakan REST API untuk sementara)
  final CourseDataSource dataSource = CourseApiService(apiBaseUrl);
  final repository = CourseRepository(dataSource);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(repository)..loadCourses(),
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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
