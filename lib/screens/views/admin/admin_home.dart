import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:violation_system/widgets/drawer_widget.dart';
import 'package:violation_system/widgets/text_widget.dart';
import 'package:intl/intl.dart';
import 'package:violation_system/widgets/view_violation_dialog.dart';

import '../officer/officer_notif_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final double maxDelta = 0.001;

  final Random rng = Random();
  Set<Marker> markers = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  addMarker(lat, lang, data) {
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

  @override
  Widget build(BuildContext context) {
    final double latDelta = (rng.nextDouble() * maxDelta * 2) - maxDelta;
    final double longDelta = (rng.nextDouble() * maxDelta * 2) - maxDelta;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(text: 'BTAV', fontSize: 24, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const OfficerNotifScreen()));
            },
            icon: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Notifs').snapshots(),
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
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextBold(text: 'Welcome Admin!', fontSize: 32, color: Colors.black),
            const SizedBox(
              height: 50,
            ),
            TextRegular(
                text: 'Recent Activities', fontSize: 18, color: Colors.grey),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Violations')
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
                  return Expanded(
                    child: SizedBox(
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
                                    text: data.docs[index]['name'],
                                    fontSize: 11,
                                    color: Colors.grey),
                                trailing: TextRegular(
                                    text: DateFormat.yMMMd().add_jm().format(
                                        data.docs[index]['dateTime'].toDate()),
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
