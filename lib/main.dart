import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/data/habit_database.dart';
import 'package:hive/hive.dart';
import 'package:habit_tracker_flutter/screens/home_page.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox("Habit_Database");
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage() ,
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}