import 'package:flutter/material.dart';
import 'package:violation_system/screens/auth/admin/admin_login.dart';
import 'package:violation_system/screens/auth/officer/office_login.dart';
import 'package:violation_system/widgets/button_widget.dart';
import 'package:violation_system/widgets/text_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 175,
            ),
            const SizedBox(
              height: 20,
            ),
            TextBold(
              text: 'T & VR',
              fontSize: 48,
              color: Colors.black,
            ),
            const SizedBox(
              height: 50,
            ),
            ButtonWidget(
              label: 'Continue as Officer',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OfficerLogin()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              label: 'Continue as Admin',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdminLogin()));
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
