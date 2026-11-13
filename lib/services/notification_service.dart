// lib/services/notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Meminta izin notifikasi
  Future<AuthorizationStatus> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('Notification permission: ${settings.authorizationStatus.name}');
    return settings.authorizationStatus;
  }

  /// Inisialisasi listener notifikasi untuk Foreground & Background
  void initNotificationListeners() {
    // 1. Ketika aplikasi dibuka dari dalam kondisi tertutup total lalu diklik notifikasinya
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint(
            'App opened from terminated state by notification: ${message.notification?.title}');
      }
    });

    // 2. Ketika aplikasi sedang aktif di layar (Foreground)
    FirebaseMessaging.onMessage.addListener((RemoteMessage message) {
      debugPrint('Received foreground message: ${message.notification?.title}');

      // Anda bisa menampilkan SnackBar atau dialog kustom di sini jika ingin
    });

    // 3. Ketika pengguna menekan notifikasi saat aplikasi berjalan di latar belakang (Background)
    FirebaseMessaging.onMessageOpenedApp.addListener((RemoteMessage message) {
      debugPrint(
          'Notification clicked in background: ${message.notification?.title}');
    });
  }
}

extension on Stream<RemoteMessage> {
  void addListener(Null Function(RemoteMessage message) param0) {}
}
