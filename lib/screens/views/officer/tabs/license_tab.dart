import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:violation_system/widgets/add_violation_dialog.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/text_widget.dart';
import '../../../../widgets/view_violation_dialog.dart';

class LicenseTab extends StatefulWidget {
  final userDetails;

  const LicenseTab({super.key, required this.userDetails});

  @override
  State<LicenseTab> createState() => _LicenseTabState();
}

class _LicenseTabState extends State<LicenseTab> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  addMarker1(lat, lang, data) {
    Marker mark1 = Marker(
        draggable: true,
        markerId: MarkerId(data['name']),
        infoWindow: const InfoWindow(
          title: 'Location of incident',
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, lang));

    markers.add(mark1);
  }

  final platenumberController = TextEditingController();
  final vehicledescriptionController = TextEditingController();
  final locationController = TextEditingController();
  final violationController = TextEditingController();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  final _dropValue1 = 0;

  List vehicles = ['Car', 'Motorcycle', 'Bus', 'Jeep', 'Van'];

  late String vehicle = 'Car';

  final licenseController = TextEditingController();

  double lat = 0;
  double long = 0;

  getLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late LatLng violationCoordinates = LatLng(lat, long);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.640739, 122.968956),
    zoom: 14.4746,
  );

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

  final double maxDelta = 0.001;

  final Random rng = Random();

  addMarker2(lat, lang) {
    Marker mark1 = Marker(
        draggable: true,
        markerId: const MarkerId('runaway'),
        infoWindow: const InfoWindow(
          title: 'Possible runaway of violator',
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, lang));

    markers.add(mark1);
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final double latDelta = (rng.nextDouble() * maxDelta * 2) - maxDelta;
    final double longDelta = (rng.nextDouble() * maxDelta * 2) - maxDelta;
    return Scaffold(
      floatingActionButton: box.read('role') == 'Officer'
          ? FloatingActionButton(
              backgroundColor: Colors.green,
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        title: TextBold(
            text: widget.userDetails['licenseNumber'],
            fontSize: 24,
            color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextBold(
                      text: widget.userDetails['name'],
                      fontSize: 18,
                      color: Colors.black),
                ),
                Center(
                    child: TextBold(
                        text:
                            '${widget.userDetails['gender']} | ${widget.userDetails['age']}',
                        fontSize: 16,
                        color: Colors.black)),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextBold(
                      text: 'Violation Records',
                      fontSize: 18,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Violations')
                        .where('licenseNumber',
                            isEqualTo: widget.userDetails['licenseNumber'])
                        .where('status', isEqualTo: 'Accepted')
                        .where('paid', isEqualTo: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return SizedBox(
                        height: 280,
                        child: ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ViolationDialog(
                                              data: data.docs[index]);
                                        });
                                  },
                                  title: TextBold(
                                      text: data.docs[index]['violation'],
                                      fontSize: 14,
                                      color: Colors.black),
                                  subtitle: TextRegular(
                                      text: data.docs[index]['location'],
                                      fontSize: 11,
                                      color: Colors.grey),
                                  trailing: TextRegular(
                                      text: DateFormat.yMMMd().add_jm().format(
                                          data.docs[index]['dateTime']
                                              .toDate()),
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
