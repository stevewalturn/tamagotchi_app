import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/pet.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    try {
      await _notifications.initialize(initializationSettings);
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize notifications. Some features may not work properly.');
    }
  }

  Future<void> checkAndNotifyPetNeeds(Pet pet) async {
    if (!_isInitialized) await initialize();

    if (!pet.needsAttention) return;

    String message;
    switch (pet.urgentNeed) {
      case 'hunger':
        message = '${pet.name} is hungry! Time for a snack!';
        break;
      case 'happiness':
        message = '${pet.name} is feeling sad. Play time?';
        break;
      case 'energy':
        message = '${pet.name} is tired. Let them rest!';
        break;
      case 'cleanliness':
        message = '${pet.name} needs a good cleaning!';
        break;
      default:
        message = '${pet.name} needs your attention!';
    }

    await _showNotification(
      title: 'Your pet needs you!',
      body: message,
    );
  }

  Future<void> notifyEvolution(String petName) async {
    if (!_isInitialized) await initialize();

    await _showNotification(
      title: 'Evolution Time! 🎉',
      body: '$petName is evolving! Check it out!',
    );
  }

  Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'tamagotchi_pet_care',
        'Pet Care Notifications',
        channelDescription: 'Notifications for pet care needs',
        importance: Importance.max,
        priority: Priority.high,
      );

      const darwinDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
      );

      await _notifications.show(
        DateTime.now().millisecond,
        title,
        body,
        details,
      );
    } catch (e) {
      throw Exception('Unable to show notification. Please check your notification settings.');
    }
  }
}