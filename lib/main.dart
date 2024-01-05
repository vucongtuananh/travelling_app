import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelling_app/firebase_options.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_bloc.dart';
import 'package:travelling_app/login/presentation/login.dart';
import 'package:travelling_app/tab/presentation/tabs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoriteTripBloc(fireStoreData: FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid)),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travelling app',
          theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff008FA0)),
            useMaterial3: true,
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const TabsScreen();
                }
                return const LoginScreen();
              }),
        ),
        designSize: const Size(390, 844),
      ),
    );
  }
}
