// lib/services/notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../pages/kos_detail_page.dart';
import '../../main.dart'; // Pastikan path ini sesuai dengan struktur proyek Anda

// --- TAMBAHKAN TOP-LEVEL FUNCTION INI DI LUAR CLASS ---
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Pastikan inisialisasi Firebase terpanggil jika diperlukan di background
  // await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint('Background message title: ${message.notification?.title}');
  debugPrint('Background message body: ${message.notification?.body}');
}

Future<void> setupInteractedMessage(dynamic _messaging) async {
  // 1. Ketika aplikasi TERMINATED lalu dibuka dari notifikasi
  final initial = await _messaging.getInitialMessage();
  if (initial != null) _handleTap(initial);

  // 2. Ketika aplikasi BACKGROUND lalu dibuka dari notifikasi
  FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);
}

void _handleTap(RemoteMessage message) {
  final kosId = message.data['kos_id'];
  if (kosId == null) return;

  // Mengarahkan pengguna ke KosDetailPage menggunakan navigatorKey
  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (_) => KosDetailPage(kosId: kosId.toString()),
    ),
  );
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<AuthorizationStatus> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('Notification permission: ${settings.authorizationStatus.name}');
    return settings.authorizationStatus;
  }

  Future<void> printFCMToken() async {
    try {
      String? token = await _messaging.getToken();
      debugPrint('FCM Device Token: $token');
    } catch (e) {
      debugPrint('Gagal mengambil FCM token: $e');
    }
  }

  /// Inisialisasi listener notifikasi untuk Foreground & Background
  void initNotificationListeners() {
    // 1. Mendaftarkan background handler ke FirebaseMessaging
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 2. Ketika aplikasi dibuka dari kondisi terminated
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint(
            'App opened from terminated state: ${message.notification?.title}');
      }
    });

    // 3. Foreground listener (seperti pada contoh modul)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Notification received');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
    });

    // 4. Background click listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'Notification clicked in background: ${message.notification?.title}');
    });
  }

  Future<void> setupInteractedMessage() async {}
}
