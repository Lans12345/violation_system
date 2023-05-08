import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:violation_system/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class ToplistTab extends StatefulWidget {
  const ToplistTab({super.key});

  @override
  State<ToplistTab> createState() => _ToplistTabState();
}

class _ToplistTabState extends State<ToplistTab> {
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
    return Container(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextBold(text: 'Top List', fontSize: 24, color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Violations')
                    .where('status', isEqualTo: 'Accepted')
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
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 500,
                                            child: GoogleMap(
                                              markers: markers,
                                              mapType: MapType.normal,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                      target: LatLng(
                                                          data.docs[index]
                                                              ['lat'],
                                                          data.docs[index]
                                                              ['long']),
                                                      zoom: 16),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                _controller
                                                    .complete(controller);
                                                setState(() {
                                                  addMarker(
                                                      data.docs[index]['lat'],
                                                      data.docs[index]['long'],
                                                      data.docs[index]);
                                                  addMarker2(
                                                      data.docs[index]['lat'] +
                                                          latDelta,
                                                      data.docs[index]['long'] +
                                                          longDelta);
                                                });
                                              },
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: TextBold(
                                                  text: 'Close',
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                title: TextBold(
                                    text: data.docs[index]['location'],
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
