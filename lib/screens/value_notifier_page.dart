import 'package:flutter/material.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011006';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({super.key});

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  // ValueNotifier untuk memantau satu nilai sederhana
  final ValueNotifier<int> _favoriteCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    _favoriteCount.dispose(); // Wajib dispose saat state dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 4 - ValueNotifier'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 36, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            studentName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('NIM: $studentId'),
                        ],
                      ),
                    ),
                    // ValueListenableBuilder hanya merender ulang area Chip ini
                    ValueListenableBuilder<int>(
                      valueListenable: _favoriteCount,
                      builder: (context, count, child) {
                        return Chip(
                          avatar: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                          label: Text('$count Favorit'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: _favoriteCount,
                      builder: (context, count, child) {
                        return Text(
                          'Jumlah Total Favorit: $count',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_favoriteCount.value > 0) {
                              _favoriteCount.value--;
                            }
                          },
                          icon: const Icon(Icons.remove),
                          label: const Text('Kurangi'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            _favoriteCount.value++;
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
