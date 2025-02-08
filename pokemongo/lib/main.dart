import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/map_controller.dart';
import 'package:pokemongo/login_signup/login.dart';
import 'package:pokemongo/login_signup/signup.dart';
import 'package:pokemongo/pages/nav.dart';
import 'package:pokemongo/service/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure bindings are initialized first
  await SharedPreferencesService.init(); // Now initialize SharedPreferences
  Get.lazyPut(() => MumbaiMapController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokemonGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NavigationTabs(),
    );
  }
}
