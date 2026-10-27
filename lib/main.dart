import 'package:flutter/material.dart';

import 'screens/change_notifier_page.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 5 - ChangeNotifier',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ChangeNotifierPage(),
    );
  }
}
