import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:violation_system/screens/views/admin/admin_home.dart';
import 'package:violation_system/screens/views/cashier/cashier_screen.dart';
import 'package:violation_system/screens/views/driver/driver_screen.dart';
import 'package:violation_system/screens/views/officer/officer_home_screen.dart';
import 'package:violation_system/widgets/textfield_widget.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/toast_widget.dart';

class OfficerLogin extends StatefulWidget {
  const OfficerLogin({super.key});

  @override
  State<OfficerLogin> createState() => _OfficerLoginState();
}

class _OfficerLoginState extends State<OfficerLogin> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final box = GetStorage();

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
                width: 320,
              ),
              const SizedBox(
                height: 50,
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
                  await FirebaseAuth.instance.signOut();
                  String role = '';
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

                      await FirebaseFirestore.instance
                          .collection('Officers')
                          .where('id',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((QuerySnapshot querySnapshot) async {
                        for (var doc in querySnapshot.docs) {
                          box.write('role', doc['role']);
                          box.write('name', doc['name']);
                          setState(() {
                            role = doc['role'];
                          });
                        }
                      });

                      if (role == 'Officer') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const OfficerHomeScreen()));
                      } else if (role == 'Cashier') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const CashierScreen()));
                      } else if (role == 'Driver') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => DriverScreen()));
                      }
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
