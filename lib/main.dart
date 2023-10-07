import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/providers/list_provider.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/home/splash_screen.dart';
import 'ui/utils/app_theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
  runApp( ChangeNotifierProvider(
      create: (_){
        return ListProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routes:{
        SplashScreen.routeName:(context) => SplashScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}

