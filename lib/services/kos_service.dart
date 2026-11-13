// lib/services/kos_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class KosService {
  final SupabaseClient _client = Supabase.instance.client;

  // Mendapatkan semua daftar kos
  Future<List<Map<String, dynamic>>> getKosList() async {
    final response = await _client
        .from('kos')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Menambah kos baru
  Future<void> addKos({
    required String name,
    required String description,
    required double price,
  }) async {
    final userId = _client.auth.currentUser!.id;
    await _client.from('kos').insert({
      'name': name,
      'description': description,
      'price': price,
      'owner_id': userId,
    });
  }

  // Menghapus kos berdasarkan ID
  Future<void> deleteKos(String id) async {
    await _client.from('kos').delete().eq('id', id);
  }

  Future<bool> update(String id, Map<String, dynamic> data) async {
    try {
      final response =
          await _client.from('kos').update(data).eq('id', id).select();
      return response.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
