import 'package:cat_dog_classifier_tensorflow_with_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  Future<void> _initSplash() async{
    // >>> Hide Native splash screen
    FlutterSplashScreen.hide();
    await Future.delayed(const Duration(seconds: 3));
    if(!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }

  @override
  Widget build(BuildContext context) {
    // Custom Flutter splash UI
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to tensorflow", style: TextStyle(color: Colors.white, fontSize: 22),textAlign: TextAlign.center,),
            const SizedBox(height: 20),
            Image.asset('assets/logo/catdog_innner_logo.png',width: 150,),
            const SizedBox(height: 20),
            const Text("Cat & dog classification", style: TextStyle(color: Colors.white, fontSize: 22),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}

