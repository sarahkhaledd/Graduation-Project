import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kherwallet/screens/User%20Screens/CategoryList_screen.dart';
import 'package:kherwallet/screens/FrequentlyAskedQuestions_screen.dart';
import 'package:kherwallet/screens/Help_screen.dart';
import 'package:kherwallet/screens/User%20Screens/Home.dart';
import 'package:kherwallet/screens/User%20Screens/Notifications_screen.dart';
import 'package:kherwallet/screens/User%20Screens/Requests_screen.dart';
import 'package:kherwallet/screens/Organization%20Screens/SignInOrganization_screen.dart';
import 'package:kherwallet/screens/User%20Screens/SignIn_screen.dart';
import 'package:kherwallet/screens/User%20Screens/SignUp_screen.dart';
import 'package:kherwallet/screens/User%20Screens/UserProfile_screen.dart';
import 'package:kherwallet/screens/WriteFeedback_screen.dart';
import 'package:kherwallet/screens/Intro_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A big message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kher Wallet',
        theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Quicksand-Bold',
      ),
      home: IntroScreen(),
      routes: {
        'SignIn': (context) => SignIn(),
        'SignUp': (context) => SignUp(),
        'Home': (context) => Home(),
        'CategoryList': (context) => CategoryList(),
        'WriteFeedback': (context) => WriteFeedback(),
        'FAQ': (context) => FrequentlyAskedQuestions(),
        'HelpScreen': (context) => HelpScreen(),
        'RequestScreen': (context) => Requests_screen(),
        'UserProfile': (context) => UserProfile_screen(),
        'SignInAsOrganization': (context) => SignInOrganization_screen(),
        'UserNotifications': (context) => Notifications_screen(),
      }
    );
  }
 }