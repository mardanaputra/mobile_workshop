import 'package:flutter/material.dart';

const String studentName = 'Suniaramana Mardana Putra';
const String studentId = '2455011010';

class StateIdentificationPage extends StatefulWidget {
  const StateIdentificationPage({super.key});

  @override
  State<StateIdentificationPage> createState() =>
      _StateIdentificationPageState();
}

class _StateIdentificationPageState extends State<StateIdentificationPage> {
  bool _showDetails = false;
  bool _isLocalFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 1 - Local vs Shared State'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mahasiswa: $studentName - $studentId',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Dart Fundamentals'),
                      trailing: IconButton(
                        icon: Icon(
                          _isLocalFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _isLocalFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLocalFavorite = !_isLocalFavorite;
                          });
                        },
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showDetails = !_showDetails;
                        });
                      },
                      icon: Icon(
                        _showDetails ? Icons.expand_less : Icons.expand_more,
                      ),
                      label: Text(
                        _showDetails
                            ? 'Sembunyikan Detail'
                            : 'Tampilkan Detail',
                      ),
                    ),
                    if (_showDetails) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Deskripsi: Mempelajari dasar bahasa Dart, OOP, dan asynchronous programming.',
                      ),
                    ],
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
