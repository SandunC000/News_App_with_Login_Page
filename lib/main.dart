import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app_2/pages/article_page.dart';
import 'package:news_app_2/pages/auth_page.dart';
import 'package:news_app_2/pages/discover_page.dart';
import 'package:news_app_2/pages/home_page.dart';
import 'package:news_app_2/pages/login_page.dart';
import 'package:news_app_2/pages/profile_page.dart';
import 'package:news_app_2/pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homePage': (context) => HomePage(),
        'registerPage': (context) => const RegisterPage(),
        'loginPage': (context) => const LoginPage(),
        'articlePage': (context) => ArticlePage(),
        'discoverPage': (context) => DiscoverPage(),
        'profilePage': (context) => const ProfilePage()
      },
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
