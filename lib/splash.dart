import 'package:ai_flutter/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "https://img.freepik.com/free-vector/graident-ai-robot-vectorart_78370-4114.jpg",
                fit: BoxFit.cover,
              ),
            ),
        
            const SizedBox(height: 60),
        
            Column(
              children: [
                const Text(
                  "Ask Anything",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "I can be your best friend & you can ask me\nanything & I will help you",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
                ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }, child: Text("START", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),))
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
