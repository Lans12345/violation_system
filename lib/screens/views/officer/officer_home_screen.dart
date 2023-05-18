import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:violation_system/screens/auth/landing_screen.dart';
import 'package:violation_system/screens/views/officer/officer_notif_screen.dart';
import 'package:violation_system/screens/views/officer/tabs/home_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/profile_tab.dart';
import 'package:violation_system/services/add_violation.dart';
import 'package:violation_system/widgets/add_violation_dialog.dart';
import 'package:violation_system/widgets/textfield_widget.dart';
import 'package:violation_system/widgets/toast_widget.dart';

import '../../../widgets/text_widget.dart';

class OfficerHomeScreen extends StatefulWidget {
  const OfficerHomeScreen({super.key});

  @override
  State<OfficerHomeScreen> createState() => _OfficerHomeScreenState();
}

class _OfficerHomeScreenState extends State<OfficerHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeTab(),
    const ProfileTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Officers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  var _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 240, 23, 95),
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AddViolationDialog();
                    });
              },
            )
          : const SizedBox(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(
            text: _currentIndex != 3 ? 'T & VR' : 'My Profile',
            fontSize: 24,
            color: Colors.white),
        centerTitle: true,
        actions: [
          _currentIndex != 1
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OfficerNotifScreen()));
                  },
                  icon: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Notifs')
                          .where('officerId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }

                        final data = snapshot.requireData;
                        return Badge(
                          isLabelVisible: data.docs.isNotEmpty,
                          label: TextRegular(
                              text: data.docs.length.toString(),
                              fontSize: 12,
                              color: Colors.white),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                          ),
                        );
                      }),
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
                ),
          StreamBuilder<DocumentSnapshot>(
              stream: userData,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SizedBox();
                }
                dynamic data = snapshot.data;
                return Container(
                  padding: const EdgeInsets.only(right: 20),
                  width: 50,
                  child: SwitchListTile(
                    value: data['isActive'],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        if (_value == true) {
                          FirebaseFirestore.instance
                              .collection('Officers')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'isActive': true,
                          });
                          showToast('Status: Active');
                        } else {
                          FirebaseFirestore.instance
                              .collection('Officers')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'isActive': false,
                          });
                          showToast('Status: Inactive');
                        }
                      });
                    },
                  ),
                );
              }),
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
