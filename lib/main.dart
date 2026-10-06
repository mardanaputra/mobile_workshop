import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Konstanta Identitas Wajib Praktikum
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
      title: 'Learning Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

// Model fungsi asynchronous pembaca JSON statik
Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Penggunaan 'late' memastikan inisialisasi dilakukan pada initState
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learning Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {
                // Latihan interaksi menggunakan setState untuk mereload data
                studentFuture = loadStudentData();
              });
            },
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error State
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat data: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // 3. Data Loaded State
          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final summary = data['summary'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Identitas Card
                Card(
                  elevation: 2,
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NIM: ${student['nim']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Nama: ${student['name']}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Program: ${student['program']} (Sem. ${student['semester']})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Reusable Widget Summary Card (Row)
                Row(
                  children: [
                    _buildStatCard(
                      label: 'Topik Selesai',
                      value:
                          '${summary['completedTopics']} / ${summary['totalTopics']}',
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      label: 'Total Beban SKS',
                      value: '${summary['totalCredits']} SKS',
                      icon: Icons.menu_book,
                      color: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Text(
                  'Daftar Materi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // ListView dengan Expanded
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index] as Map<String, dynamic>;
                      return _buildCourseCard(course);
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    'Data list dimuat dari JSON statik • $studentId',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Reusable Widget 1: Card Statistik
  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget 2: Card Item Materi
  Widget _buildCourseCard(Map<String, dynamic> course) {
    final String status = course['status'];
    Color statusColor;
    IconData statusIcon;
    String statusLabel;

    if (status == 'done') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusLabel = 'Selesai';
    } else if (status == 'active') {
      statusColor = Colors.orange;
      statusIcon = Icons.timelapse;
      statusLabel = 'Berjalan';
    } else {
      statusColor = Colors.grey;
      statusIcon = Icons.schedule;
      statusLabel = 'Rencana';
    }

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor, size: 26),
        title: Text(
          course['title'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text('${course['code']} • ${course['credits']} SKS'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
