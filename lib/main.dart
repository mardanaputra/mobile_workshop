import 'package:flutter/material.dart';

import 'screens/lifting_state_up_page.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 3 - Lifting State Up',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const LiftingStateUpPage(),
    );
  }
}
