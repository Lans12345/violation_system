import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:violation_system/screens/auth/landing_screen.dart';
import 'package:violation_system/screens/views/officer/officer_notif_screen.dart';
import 'package:violation_system/screens/views/officer/tabs/active_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/home_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/profile_tab.dart';
import 'package:violation_system/screens/views/officer/tabs/toplist_tab.dart';
import 'package:violation_system/services/add_toplist.dart';
import 'package:violation_system/services/add_violation.dart';
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
    determinePosition();
    getLocation();
  }

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

  double lat = 0;
  double long = 0;

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.640739, 122.968956),
    zoom: 14.4746,
  );

  late LatLng violationCoordinates = LatLng(lat, long);

  addMarker(lat, lang) {
    Marker mark1 = Marker(
        onDragEnd: (value) {
          setState(() {
            violationCoordinates = value;
          });
        },
        draggable: true,
        markerId: const MarkerId('mark1'),
        infoWindow: const InfoWindow(
          title: 'Your Current Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: const LatLng(10.640739, 122.968956));

    markers.add(mark1);
  }

  Set<Marker> markers = {};

  GoogleMapController? mapController;

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

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Officers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  var _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentIndex == 1 || _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 240, 23, 95),
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
                                SizedBox(
                                  height: 300,
                                  child: GoogleMap(
                                    markers: markers,
                                    mapType: MapType.normal,
                                    initialCameraPosition: _kGooglePlex,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                      setState(() {
                                        addMarker(lat, long);
                                        mapController = controller;
                                      });
                                    },
                                  ),
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
                              if (_currentIndex == 1) {
                                Navigator.of(context).pop();
                                addTopList(
                                    vehicle,
                                    nameController.text,
                                    genderController.text,
                                    ageController.text,
                                    violationController.text,
                                    licenseController.text,
                                    platenumberController.text,
                                    vehicledescriptionController.text,
                                    locationController.text,
                                    violationCoordinates.latitude,
                                    violationCoordinates.longitude);
                                locationController.clear();
                                vehicledescriptionController.clear();
                                platenumberController.clear();
                                ageController.clear();
                                nameController.clear();
                                violationController.clear();
                                genderController.clear();
                                showToast('Top List Added!');
                              } else {
                                Navigator.of(context).pop();
                                addViolation(
                                    vehicle,
                                    nameController.text,
                                    genderController.text,
                                    ageController.text,
                                    violationController.text,
                                    licenseController.text,
                                    platenumberController.text,
                                    vehicledescriptionController.text,
                                    locationController.text,
                                    violationCoordinates.latitude,
                                    violationCoordinates.longitude);
                                locationController.clear();
                                vehicledescriptionController.clear();
                                platenumberController.clear();
                                ageController.clear();
                                nameController.clear();
                                violationController.clear();
                                genderController.clear();
                                showToast('Violation Added!');
                              }
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
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
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
