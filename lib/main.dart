import 'package:cat_dog_classifier_tensorflow_with_flutter/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarThemeData(backgroundColor: Color(0xff004242),foregroundColor: Colors.white,elevation: 0,centerTitle: true,iconTheme: IconThemeData(color: Colors.white)),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(foregroundColor: Colors.white,backgroundColor: Colors.brown,elevation: 3,iconColor: Colors.white,iconSize: 20,shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(25))))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MySplash(),
    );
  }
}