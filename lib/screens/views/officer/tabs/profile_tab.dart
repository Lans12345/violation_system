import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:violation_system/widgets/text_widget.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/view_violation_dialog.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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

  @override
  Widget build(BuildContext context) {
    final double latDelta = (rng.nextDouble() * maxDelta * 2) - maxDelta;
    final double longDelta = (rng.nextDouble() * maxDelta * 2) - maxDelta;
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Officers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading'));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          dynamic data = snapshot.data;
          return Container(
            child: SingleChildScrollView(
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
                            text: data['name'],
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Center(
                          child: TextBold(
                              text: '${data['gender']} | ${data['age']}',
                              fontSize: 16,
                              color: Colors.black)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextRegular(
                          text: 'Username: ${data['username']}',
                          fontSize: 14,
                          color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                      TextRegular(
                          text: 'Contact Number: ${data['contactNumber']}',
                          fontSize: 14,
                          color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                      TextRegular(
                          text: 'Address: ${data['address']}',
                          fontSize: 14,
                          color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                      TextRegular(
                          text: data['isActive'] == true
                              ? 'Status: Active'
                              : 'Status: Inactive',
                          fontSize: 14,
                          color: Colors.grey),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextBold(
                            text: 'History Records',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Violations')
                              .where('officerId',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .where('status', isEqualTo: 'Accepted')
                              .where('paid', isEqualTo: false)
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
                            return SizedBox(
                              height: 280,
                              child: ListView.builder(
                                itemCount: data.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                                            text: DateFormat.yMMMd()
                                                .add_jm()
                                                .format(data.docs[index]
                                                        ['dateTime']
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
        });
  }
}
