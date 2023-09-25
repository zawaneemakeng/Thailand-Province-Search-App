import 'package:flutter/material.dart';
import 'package:province/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Province Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff5C6795),
        ),
        useMaterial3: true,
      ),
      home: const IntroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
