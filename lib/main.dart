import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelling_app/screens/tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff008FA0)),
        useMaterial3: true,
      ),
      home: const TabsScreen(),
    );
  }
}
