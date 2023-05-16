import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/screens/views/admin/admin_home.dart';
import 'package:violation_system/screens/views/officer/officer_home_screen.dart';
import 'package:violation_system/widgets/textfield_widget.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/toast_widget.dart';

class OfficerLogin extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  OfficerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                height: 30,
              ),
              TextFieldWidget(
                  label: 'Username', controller: usernameController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  isObscure: true,
                  label: 'Password',
                  controller: passwordController),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                label: 'Login',
                onPressed: () async {
                  if (usernameController.text == 'admin-username' &&
                      passwordController.text == 'admin-password') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdminHome()));
                    showToast('Logged in succesfully!');
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: '${usernameController.text}@officer.com',
                          password: passwordController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const OfficerHomeScreen()));
                      showToast('Logged in succesfully!');
                    } on Exception catch (e) {
                      showToast("An error occurred: $e");
                    }
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
