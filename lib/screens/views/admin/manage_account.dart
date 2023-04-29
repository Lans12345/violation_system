import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/screens/views/admin/admin_home.dart';
import 'package:violation_system/services/add_account.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/toast_widget.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  late String userName = '';

  late String password = '';

  late String firstName = '';

  late String contactNumber = '';

  late String lastName = '';

  late String age = '';

  late String address = '';

  late String gender = 'Male';
  final List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xff6571E0),
        title: TextBold(
            text: 'Manage Accounts', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextBold(
                text: 'Login Credentials', fontSize: 18, color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  userName = input;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  password = input;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextBold(
                text: 'User Information', fontSize: 18, color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  firstName = input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'First Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  lastName = input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Last Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  contactNumber = input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Contact Number',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ToggleButtons(
                borderRadius: BorderRadius.circular(5),
                splashColor: Colors.grey,
                color: Colors.black,
                selectedColor: Colors.blue,
                onPressed: (int newIndex) {
                  setState(() {
                    for (int index = 0; index < _isSelected.length; index++) {
                      if (index == newIndex) {
                        _isSelected[index] = true;
                        if (_isSelected[0] == true) {
                          gender = 'Male';
                        } else {
                          gender = 'Female';
                        }
                      } else {
                        _isSelected[index] = false;
                      }
                    }
                  });
                },
                isSelected: _isSelected,
                children: const [
                  Icon(Icons.male),
                  Icon(Icons.female),
                ]),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  age = input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Age',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                minLines: 3,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (input) {
                  address = input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Address',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: const Color(0xff6571E0),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Signup',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Account Created Succesfully!',
                            style: TextStyle(fontFamily: 'Quicksand'),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () async {
                                try {
                                  final user = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: '$userName@officer.com',
                                          password: password);

                                  addAccount(
                                      userName,
                                      '$firstName $lastName',
                                      password,
                                      contactNumber,
                                      gender,
                                      age,
                                      address,
                                      user.user!.uid);

                                  showToast("Registered Succesfully!");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminHome()));
                                } on Exception catch (e) {
                                  showToast("An error occurred: $e");
                                }
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(75, 15, 75, 15),
                child: TextRegular(
                    text: 'Continue', fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
