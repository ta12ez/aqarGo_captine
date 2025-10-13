import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:manzal_office/core/controller/payment_controller/payment_cubit.dart';
import 'package:manzal_office/core/style/theme.dart';
import 'package:manzal_office/features/auth/login.dart';
import 'package:manzal_office/features/auth/splash_screen.dart';
import 'package:manzal_office/features/home_page/controller/home_cubit.dart';
import 'package:manzal_office/features/wallet_screen/controller/wallet_cubit.dart';
import 'core/constant/app_localizations.dart';
import 'core/network/local/cachHelper.dart';
import 'core/network/remote/dioHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'core/component/notefcation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin(); // جديد

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message); // جديد
  print('رسالة بالخلفية: ${message.messageId}');
}

// دالة عرض الإشعار
void _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id', // يمكن تغييره لاحقًا حسب الحاجة
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: true,
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'إشعار',
    message.notification?.body ?? 'محتوى الإشعار',
    platformChannelSpecifics,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Stripe.publishableKey =
  "pk_test_51RxDES3mhTiHRgqWVLsEVIHhl2ITbu3qQO3cg61UJWtBkq9REauiVcQGNGmDT7vy4yEGUnyhjgGWmX32Vq3hyXZd00mgYM5Edp";
  await Stripe.instance.applySettings();

  // إشعارات الخلفية
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // تهيئة local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final notificationService = NotificationService();
  await notificationService.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),

        // BlocProvider(
        //   create: (context) => WalletCubit(),
        //   lazy: true,
        // ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            locale: cubit.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (_, supportedLocales) => cubit.locale,

            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

