import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/firebase_options.dart';
import 'package:todo_fb/screen/home/provider/screen_provider.dart';
import 'package:todo_fb/screen/home/view/home_screen.dart';
import 'package:todo_fb/screen/insert/view/insert_screen.dart';
import 'package:todo_fb/screen/signin/view/signin_screen.dart';
import 'package:todo_fb/screen/signup/view/signup_screen.dart';
import 'package:todo_fb/screen/splash/view/splash_screen.dart';
import 'package:todo_fb/screen/update/view/update_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ScreenProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        routes: {
          '/': (context) => const SplashScreen(),
          'signin_screen': (context) => const SigninScreen(),
          'signup_screen': (context) => const SignupScreen(),
          'home_screen': (context) => const HomeScreen(),
          'insert_screen': (context) => const InsertScreen(),
          'update_screen': (context) => const UpdateScreen(),
        },
      ),
    ),
  );
}

// validation, enter
// responsive
// code format
// user detail
