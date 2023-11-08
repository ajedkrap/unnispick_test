import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unnispick_test/screens/login_screen.dart';
import 'package:unnispick_test/screens/registration_screen.dart';
import 'package:unnispick_test/screens/weather_detail_screen.dart';
import 'package:unnispick_test/screens/weathers_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UnnispickTestApp());
}

class UnnispickTestApp extends StatefulWidget {
  const UnnispickTestApp({super.key});

  @override
  State<UnnispickTestApp> createState() => _UnnispickTestApp();
}

class _UnnispickTestApp extends State<UnnispickTestApp> {
  final _auth = FirebaseAuth.instance;

  late String initialRoute = LoginScreen.id;

  void getCurrentUser() async {
    try {
      _auth.authStateChanges().listen((User? user) {
        setState(() {
          initialRoute = user == null ? LoginScreen.id : WeathersScreen.id;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        WeathersScreen.id: (context) => const WeathersScreen(),
        WeatherDetailScreen.id: (context) =>
            const WeatherDetailScreen(weatherData: null, index: 0),
      },
      // home: const WelcomeScreen(),
    );
  }
}
