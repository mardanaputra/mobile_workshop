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
      title: 'Course Explorer - Tahap 9',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CourseListPage(),
    );
  }
}

// Data Dummy Course
final List<Map<String, dynamic>> courseList = [
  {
    'title': 'Responsive Layout',
    'code': 'MOB04',
    'status': 'Active',
    'credits': 3,
    'description': 'Membangun antarmuka adaptif menggunakan MediaQuery, LayoutBuilder, serta penanganan breakpoint ukuran layar.',
  },
  {
    'title': 'Navigation',
    'code': 'MOB05',
    'status': 'Planned',
    'credits': 2,
    'description': 'Mempelajari navigasi multi-screen, tumpukan rute (stack), passing data antar-halaman, dan returning result.',
  },
  {
    'title': 'Interaction',
    'code': 'MOB06',
    'status': 'Planned',
    'credits': 3,
    'description': 'Menerapkan interaksi pengguna menggunakan buttons, InkWell ripple, form validation, dan feedback widget.',
  },
];

// 1. Layar Daftar Course (Menerima returning data dengan await)
class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
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
              '$studentId - $studentName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Daftar Course (Tahap 9 - Return Data):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                final course = courseList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      course['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${course['code']} • ${course['credits']} SKS',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    // Menunggu hasil kembalian dari CourseDetailPage
                    onTap: () async {
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseDetailPage(course: course),
                        ),
                      );

                      // Jika user menekan tombol 'Pilih/Favorite' (result == true)
                      if (context.mounted && result == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${course['title']} ditambahkan ke Favorite oleh $studentName!',
                            ),
                            backgroundColor: Colors.green.shade700,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
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

// 2. Layar Detail Course (Mengirimkan hasil kembali via pop)
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas Mahasiswa di Layar Detail
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.badge, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Praktikan: $studentId - $studentName',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              course['title'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Kode: ${course['code']} | Beban: ${course['credits']} SKS',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const Divider(height: 32),
            const Text(
              'Deskripsi Materi:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              course['description'] ?? '-',
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            const Spacer(),

            // Tombol 'Pilih/Favorite' yang mengembalikan data boolean true
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Kembali sambil mengirim nilai true
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.star),
                label: const Text(
                  'Pilih/Favorite',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Tombol kembali biasa tanpa mengirim nilai (null)
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal / Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
