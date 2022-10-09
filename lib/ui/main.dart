import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:here_sdk/core.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/cubit/harga_cubit.dart';
import 'package:lazywash/cubit/page_cubit.dart';
import 'package:lazywash/cubit/pesanan_cubit.dart';
import 'package:lazywash/ui/page/admin/admin_daftar_penyedia_jasa.dart';
import 'package:lazywash/ui/page/admin/admin_page.dart';
import 'package:lazywash/ui/page/admin/admin_verifikasi_pembayaran.dart';
import 'package:lazywash/ui/page/penyedia/detail_gmap_route_penyedia.dart';
import 'package:lazywash/ui/page/user/detail_pesan1.dart';
import 'package:lazywash/ui/page/user/detail_pesan2.dart';
import 'package:lazywash/ui/page/user/edit_profile.dart';
import 'package:lazywash/ui/page/penyedia/edit_profile_penyedia.dart';
import 'package:lazywash/ui/page/halaman%20utama/get_started_page.dart';
import 'package:lazywash/ui/page/user/main_history.dart';
import 'package:lazywash/ui/page/user/main_page.dart';
import 'package:lazywash/ui/page/penyedia/main_page_penyedia.dart';
import 'package:lazywash/ui/page/user/pembayaran.dart';
import 'package:lazywash/ui/page/user/profile_page.dart';
import 'package:lazywash/ui/page/halaman%20utama/sign_in_page.dart';
import 'package:lazywash/ui/page/halaman%20utama/sign_up_page.dart';
import 'package:lazywash/ui/page/halaman%20utama/splash_page.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_notifications',
  'this channel is used for important notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SdkContext.init(IsolateOrigin.main);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => PesananCubit(),
        ),
        BlocProvider(
          create: (context) => HargaCubit(),
        ),
      ],
      child: MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/get-started': (context) => GetStartedPage(),
          '/sign_up': (context) => SignUpPage(),
          '/sign_in': (context) => SignInPage(),
          '/home': (context) => MainPage(),
          '/home_penyedia': (context) => MainPagePenyedia(),
          '/detail_pesan1': (context) => DetailPesan1(),
          '/detail_pesan2': (context) => DetailPesan2(),
          '/profile': (context) => ProfilePage(),
          '/edit_profile': (context) => EditProfile(),
          '/history': (context) => HistoryPage(),
          '/pembayaran': (context) => PembayaranPage(),
          '/edit_profile_penyedia': (context) => EditProfilePenyedia(),
          '/detail_route': (context) => DetailGmapRoute(),
          '/admin': (context) => AdminPage(),
          '/admin_daftar_penyedia_jasa': (context) => AdminDaftarPenyediaJasa(),
          '/admin_verifikasi_pesanan': (context) => AdminVerifikasiPembayaran(),
          '/sign_up_penyedia': (context) => AdminDaftarPenyediaJasa(),
        },
      ),
    );
  }
}
