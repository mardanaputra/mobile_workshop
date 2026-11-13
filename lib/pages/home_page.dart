// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../services/kos_service.dart';
import '../widgets/role_guard.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<UserProfile?> _profileFuture;
  final KosService _kosService = KosService();

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService().getMyProfile();
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final myId = Supabase.instance.client.auth.currentUser!.id;

    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, profileSnap) {
        if (profileSnap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final p = profileSnap.data;
        if (profileSnap.hasError || p == null) {
          return const Scaffold(
            body: Center(child: Text('Gagal memuat profil')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('KosFinder (${p.role})'),
            actions: [
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            ],
          ),
          // Memperbaiki tipe data FutureBuilder menjadi List>
          body: FutureBuilder<List>(
            future: _kosService.getKosList(),
            builder: (context, kosSnap) {
              if (kosSnap.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (kosSnap.hasError) {
                return const Center(child: Text('Gagal memuat daftar kos'));
              }

              final items = kosSnap.data ?? [];

              if (items.isEmpty) {
                return const Center(child: Text('Belum ada data kos'));
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final kos = items[i];
                  final isMine = kos['owner_id'] == myId;

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(kos['name'] ?? '-'),
                      subtitle: Text(
                        '${kos['description'] ?? '-'}\nRp ${kos['price'] ?? 0}',
                      ),
                      isThreeLine: true,
                      trailing: isMine
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // TODO: Form Edit Kos
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _kosService.deleteKos(kos['id']);
                                    setState(() {}); // Refresh tampilan
                                  },
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          ),
          floatingActionButton: RoleGuard(
            role: p.role,
            allowed: const ['owner', 'admin'],
            child: FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Buka form Tambah Kos')),
                );
              },
              icon: const Icon(Icons.add_home),
              label: const Text('Tambah Kos'),
            ),
          ),
        );
      },
    );
  }
}