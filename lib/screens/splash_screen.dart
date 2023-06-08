import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:violation_system/widgets/text_widget.dart';

import 'auth/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LandingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/FLASHVIEW.png',
                width: 350,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextRegular(
                  text:
                      '"BTAV: Empowering Communities to Report Street Violations and Foster Safer Roads"',
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  child: SpinKitThreeBounce(
                    color: Colors.green,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
