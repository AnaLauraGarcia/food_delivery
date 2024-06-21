import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen ({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

// 01:36:16

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController( // Durante cuando time
      vsync: this, 
      duration: const Duration(seconds: 2));
    animation = CurvedAnimation( // Que tipo de animation
      parent: controller, 
      curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/image/popular1.jpg"))
        ]
      )

    );
  }
}