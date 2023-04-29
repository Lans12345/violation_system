import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/screens/auth/landing_screen.dart';
import 'package:violation_system/screens/views/officer/officer_notif_screen.dart';
import 'package:violation_system/screens/views/officer/tabs/active_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/home_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/profile_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/toplist_tab.dart';
import 'package:violation_system/widgets/textfield_widget.dart';
import 'package:violation_system/widgets/toast_widget.dart';

import '../../../widgets/text_widget.dart';

class OfficerHomeScreen extends StatefulWidget {
  const OfficerHomeScreen({super.key});

  @override
  State<OfficerHomeScreen> createState() => _OfficerHomeScreenState();
}

class _OfficerHomeScreenState extends State<OfficerHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeTab(),
    const ToplistTab(),
    const ActiveTab(),
    const ProfileTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final platenumberController = TextEditingController();
  final vehicledescriptionController = TextEditingController();
  final locationController = TextEditingController();
  final licenseController = TextEditingController();
  final violationController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  var _dropValue1 = 0;

  List vehicles = ['Car', 'Motorcycle', 'Bus', 'Jeep', 'Van'];

  late String vehicle = 'Car';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: const Color(0xff6571E0),
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: TextBold(
                            text: 'Adding Violation',
                            fontSize: 18,
                            color: Colors.black),
                        content: StatefulBuilder(builder: (context, setState) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextRegular(
                                      text: 'Vehicle Type',
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 300,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        focusColor: Colors.white,
                                        value: _dropValue1,
                                        items: [
                                          for (int i = 0;
                                              i < vehicles.length;
                                              i++)
                                            DropdownMenuItem(
                                              onTap: (() {
                                                vehicle = vehicles[i];
                                              }),
                                              value: i,
                                              child: Row(
                                                children: [
                                                  TextRegular(
                                                      text: '${vehicles[i]}',
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                        ],
                                        onChanged: ((value) {
                                          setState(() {
                                            _dropValue1 =
                                                int.parse(value.toString());
                                          });
                                        })),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Name', controller: nameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Gender',
                                    controller: genderController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Age', controller: ageController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Violation/s',
                                    controller: violationController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'License Number',
                                    controller: licenseController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Plate Number',
                                    controller: platenumberController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Vehicle Description',
                                    controller: vehicledescriptionController),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                    label: 'Location',
                                    controller: locationController),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        }),
                        actions: [
                          MaterialButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: TextRegular(
                                text: 'Close',
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              locationController.clear();
                              vehicledescriptionController.clear();
                              platenumberController.clear();
                              ageController.clear();
                              nameController.clear();
                              violationController.clear();
                              genderController.clear();

                              Navigator.of(context).pop();
                              showToast('Violation Added!');
                            },
                            child: TextBold(
                                text: 'Continue',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ],
                      );
                    });
              },
            )
          : const SizedBox(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: const Color(0xff6571E0),
        title: TextBold(
            text: _currentIndex != 3 ? 'T & VR' : 'My Profile',
            fontSize: 24,
            color: Colors.white),
        centerTitle: true,
        actions: [
          _currentIndex != 3
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OfficerNotifScreen()));
                  },
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: TextBold(
                                  text: 'Logout Confirmation',
                                  color: Colors.black,
                                  fontSize: 14),
                              content: TextRegular(
                                  text: 'Are you sure you want to logout?',
                                  color: Colors.black,
                                  fontSize: 16),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: TextBold(
                                      text: 'Close',
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LandingScreen()));
                                  },
                                  child: TextBold(
                                      text: 'Continue',
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: 'QBold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'QBold'),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Top List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction),
            label: 'Active',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
