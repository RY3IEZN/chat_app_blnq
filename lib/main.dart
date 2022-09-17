import 'package:flutter/material.dart';
import 'package:flutter_chat_app_notiimagpck/screens/chat_screen.dart';
import 'package:flutter_chat_app_notiimagpck/screens/contact_list_screen.dart';
import 'package:flutter_chat_app_notiimagpck/screens/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
