import 'package:flutter/material.dart';

// Identitas Mahasiswa
const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

void main() {
  runApp(const DebuggingLabApp());
}

class DebuggingLabApp extends StatelessWidget {
  const DebuggingLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 16 - Debugging Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const DebuggingChallengePage(),
    );
  }
}

class DebuggingChallengePage extends StatefulWidget {
  const DebuggingChallengePage({super.key});

  @override
  State<DebuggingChallengePage> createState() => _DebuggingChallengePageState();
}

class _DebuggingChallengePageState extends State<DebuggingChallengePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isNavigating = false; // Mencegah aksi ganda pada Kasus D

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Fungsi navigasi yang aman dari double-tap (Kasus D)
  void _safeNavigate(BuildContext context) {
    if (_isNavigating) return; // Kunci jika sedang dalam proses navigasi

    setState(() => _isNavigating = true);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(title: const Text('Detail Screen')),
          body: Center(
            child: Text(
              'Halaman berhasil dibuka!\nOleh: $studentName ($studentId)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    ).then((_) {
      // Buka kembali kunci saat rute pop/kembali
      if (mounted) {
        setState(() => _isNavigating = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 16: Debugging Challenge'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Kasus A: Row Overflow'),
            Tab(text: 'Kasus B: Unbounded List'),
            Tab(text: 'Kasus C: Keyboard Overflow'),
            Tab(text: 'Kasus D: Double Navigate'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner Identitas Mahasiswa
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.red.shade50,
            child: const Text(
              'Praktikan: $studentId -$studentName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // KASUS A: Perbaikan RenderFlex Overflow pada Row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Solusi Kasus A: Row dengan Expanded',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.info, color: Colors.green),
                            SizedBox(width: 8),
                            // Expanded memberi batasan lebar agar teks wrap ke baris baru
                            Expanded(
                              child: Text(
                                '$studentId$studentName teks sangat panjang yang berpotensi overflow jika tidak dibungkus dengan widget Expanded atau Flexible.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // KASUS B: Perbaikan ListView di dalam Column
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Solusi Kasus B: ListView dalam Expanded',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // ListView dibungkus Expanded agar constraint tingginya bounded
                      Expanded(
                        child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              leading: const Icon(Icons.check_circle_outline),
                              title: Text('Item Perkuliahan ${index + 1}'),
                              subtitle: const Text('Identitas: $studentId'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // KASUS C: Form dengan SingleChildScrollView
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Solusi Kasus C: Form di Bawah Layar + ScrollView',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Fokuskan kursor pada textfield di bawah untuk memunculkan keyboard virtual tanpa memicu bottom overflowed.',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 280,
                      ), // Simulasi form di bagian bawah
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Ketik pesan / ulasan',
                          hintText: '$studentName...',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),

                // KASUS D: Mencegah Double Navigation
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Solusi Kasus D: Debouncing Navigasi Ganda',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Tekan tombol berkali-kali secara cepat. Flag boolean `_isNavigating` akan mengabaikan penekanan berulang sehingga route hanya terbuka 1 kali.',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: () => _safeNavigate(context),
                          icon: const Icon(Icons.open_in_new),
                          label: Text(
                            _isNavigating
                                ? 'Membuka...'
                                : 'Buka Halaman (Aman)',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
