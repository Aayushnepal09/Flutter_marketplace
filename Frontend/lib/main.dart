import 'package:KinBech/helper/objectbox.dart';
import 'package:KinBech/state/objectbox_state.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  AwesomeNotifications()
      .initialize('android/app/src/main/res/drawable/launcher.png', [
    NotificationChannel(
      channelGroupKey: 'basic_channel_group',
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic text',
      defaultColor: Colors.black,
      importance: NotificationImportance.Max,
      ledColor: Colors.white,
      channelShowBadge: true,
    ),
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  runApp(
    const MyApp(),
  );
}
