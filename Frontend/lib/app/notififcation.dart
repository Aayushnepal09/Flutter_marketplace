import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    _checkNotificationScreenEnable() {
      AwesomeNotifications().isNotificationAllowed().then(
        (isAllowed) {
          if (!isAllowed) {
            AwesomeNotifications().requestPermissionToSendNotifications();
          }
        },
      );
    }

    @override
    void initState() {
      _checkNotificationScreenEnable();
      super.initState();
    }

    return const Placeholder();
  }
}
