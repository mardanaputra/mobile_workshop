import 'package:flutter/material.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

class Course {
  final String title;
  final String code;
  final String status;
  final int credits;
  final String description;
  bool isFavorite;

  Course({
    required this.title,
    required this.code,
    required this.status,
    required this.credits,
    required this.description,
    this.isFavorite = false,
  });
}

class StudentHeaderBanner extends StatelessWidget {
  const StudentHeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: const Row(
        children: [
          Icon(Icons.badge, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '$studentId - $studentName (TRPL 5A)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseItemCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const CourseItemCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      course.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: course.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${course.code} • ${course.credits} SKS',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: course.status == 'Active'
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      course.status,
                      style: TextStyle(
                        color: course.status == 'Active'
                            ? Colors.green.shade900
                            : Colors.orange.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
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
}

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final List<Course> _courses = [
    Course(
      title: 'Responsive Layout',
      code: 'MOB04',
      status: 'Active',
      credits: 3,
      description: 'Membangun UI adaptif dengan MediaQuery, LayoutBuilder, dan breakpoint.',
    ),
    Course(
      title: 'Navigation',
      code: 'MOB05',
      status: 'Planned',
      credits: 2,
      description:
          'Menguasai navigasi multi-screen, routing stack, dan data return.',
    ),
    Course(
      title: 'User Interaction',
      code: 'MOB06',
      status: 'Planned',
      credits: 3,
      description: 'Menangani buttons, ripple InkWell, gesture, dan dialog.',
    ),
    Course(
      title: 'State Management',
      code: 'MOB07',
      status: 'Planned',
      credits: 3,
      description:
          'Manajemen state lokal dan global pada ekosistem Flutter modern.',
    ),
    Course(
      title: 'API & Networking',
      code: 'MOB08',
      status: 'Planned',
      credits: 3,
      description:
          'Konsumsi RESTful API, integrasi JSON, dan komunikasi asynchronous.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompactOrMedium = constraints.maxWidth < 840;

        final List<Widget> pages = [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeaderBanner(),
                const SizedBox(height: 20),
                const Text(
                  'Course Explorer Dashboard',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Aplikasi ini memadukan responsive layout, navigasi adaptif, form validation, dan feedback user.',
                  style: TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jumlah Kursus: ${_courses.length} Materi'),
                        const SizedBox(height: 6),
                        Text(
                          'Favorit Dipilih: ${_courses.where((c) => c.isFavorite).length}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentHeaderBanner(),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth < 600
                          ? 1
                          : (constraints.maxWidth < 900 ? 2 : 3),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: constraints.maxWidth < 600 ? 2.8 : 1.8,
                    ),
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      final course = _courses[index];
                      return CourseItemCard(
                        course: course,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  CourseDetailPage(course: course),
                            ),
                          ).then((value) {
                            if (value == true) {
                              setState(() => course.isFavorite = true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${course.title} ditambahkan ke favorit!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          });
                        },
                        onFavoriteToggle: () {
                          setState(
                            () => course.isFavorite = !course.isFavorite,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const FeedbackProfilePage(),
        ];

        if (isCompactOrMedium) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Course Explorer'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: pages[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Icons.school),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Course Explorer (Expanded Mode)'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (i) =>
                    setState(() => _selectedIndex = i),
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school),
                    label: Text('Courses'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: pages[_selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderBanner(),
            const SizedBox(height: 20),
            Text(
              course.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kode: ${course.code} | Bobot: ${course.credits} SKS | Status: ${course.status}',
            ),
            const Divider(height: 30),
            const Text(
              'Deskripsi Pembelajaran:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.star),
                label: const Text('Tandai sebagai Favorit & Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackProfilePage extends StatefulWidget {
  const FeedbackProfilePage({super.key});

  @override
  State<FeedbackProfilePage> createState() => _FeedbackProfilePageState();
}

class _FeedbackProfilePageState extends State<FeedbackProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Pengiriman'),
        content: Text('Kirim ulasan atas nama $studentName ($studentId)?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _feedbackController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback berhasil dikirim! Terima kasih.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderBanner(),
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                studentName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'NIM: $studentId | Kelas: TRPL 5A',
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            const Divider(height: 36),
            const Text(
              'Form Ulasan & Masukan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Tuliskan masukan Anda (minimal 5 karakter)...',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val == null || val.trim().length < 5) {
                  return 'Komentar minimal 5 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: _submitFeedback,
                icon: const Icon(Icons.send),
                label: const Text('Kirim Ulasan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
