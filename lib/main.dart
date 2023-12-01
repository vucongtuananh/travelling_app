import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelling_app/bloc/favorite_bloc.dart';
import 'package:travelling_app/modules/login_screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IsFavorite(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travelling app',
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff008FA0)),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
