import 'package:flutter/material.dart';
import 'package:main_weekfive/function/db_function.dart';
import 'package:main_weekfive/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 199, 157)),
          useMaterial3: true,
        ),
        home: Home_Screen());
  }
}
