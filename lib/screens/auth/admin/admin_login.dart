import 'package:flutter/material.dart';
import 'package:violation_system/widgets/textfield_widget.dart';
import 'package:violation_system/widgets/toast_widget.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

class AdminLogin extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  AdminLogin({super.key});

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
                label: 'Login as Admin',
                onPressed: () {
                  if (usernameController.text == 'admin-username' &&
                      passwordController.text == 'admin-password') {
                    showToast('Logged in succesfully!');
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AdminLogin()));
                  } else {
                    showToast('Invalid account! Please try again');
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
