import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004242),
      appBar: AppBar(title: const Text("Cat & Dog Classification"), backgroundColor: const Color(0xff004242),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            const Text("Tensorflow", style: TextStyle(color: Color(0xff7d9e9e), fontSize: 20),),
            const SizedBox(height: 5),
            const Text("Cats & dogs detector app", style: TextStyle(color: Color(0xff7d9e9e), fontSize: 30, fontWeight: FontWeight.w500,),),
            const SizedBox(height: 40),

            // Image Section
            Expanded(child: Center(child: Image.asset("assets/logo/catdog_innner_logo.png", width: double.infinity, height: 250, fit: BoxFit.contain,),),),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Camera"),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15),),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_library),
                      label: const Text("Gallery"),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
