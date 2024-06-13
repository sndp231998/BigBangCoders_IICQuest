import 'package:flutter/material.dart';
import 'package:hackathon/features/auth/pages/login_page.dart';
import 'package:hackathon/features/consult/pages/dashboard.dart';
import 'package:hackathon/features/home/pages/home.dart';
import 'package:hackathon/features/selfdevelopment/pages/selfdevelopment.dart';
import 'package:hackathon/providers/auth_provider.dart';
import 'package:hackathon/providers/note_provider.dart';
import 'package:hackathon/providers/screen_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ScreenProvider>(create: (_) => ScreenProvider()),
        ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Focus',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);    // Handle null value from authProvider.getId
    final isAuthenticated = authProvider.getId != 0;

    // return isAuthenticated ? const Home() : const LoginPage();
    // return const Dashboard();
    return Home();
    // return SelfDevelopment();
  }
}
