import 'package:flutter/material.dart';

import 'screens/value_notifier_page.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 4 - ValueNotifier',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ValueNotifierPage(),
    );
  }
}
