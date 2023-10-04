import 'package:flutter/material.dart';
import 'package:todo_sun_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sun_c9/ui/screens/home/splash_screen.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes:{
        SplashScreen.routeName:(context) => SplashScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}

