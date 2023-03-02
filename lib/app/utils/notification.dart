import 'package:awesome_notifications/awesome_notifications.dart';

class MyNotification {
  static Future<void> showNotification(
      {required String notificationTitle,
      required String notificationMessage}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: notificationTitle,
        body: notificationMessage,
        // locked: true
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
