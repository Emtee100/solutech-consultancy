import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visits_tracker/pages/visits.dart';
import 'package:visits_tracker/provider/app_logic.dart';
import 'package:visits_tracker/themes/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppLogic(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visits Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeMode.system,
      home: const Visits(),
    );
  }
}