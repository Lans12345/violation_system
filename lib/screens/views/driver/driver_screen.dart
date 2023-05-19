import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/view_violation_dialog.dart';
import '../../auth/landing_screen.dart';
import 'package:intl/intl.dart';

class DriverScreen extends StatelessWidget {
  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('Officers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  final box = GetStorage();

  DriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(text: 'T & VR', fontSize: 24, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
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
                            onPressed: () => Navigator.of(context).pop(true),
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
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
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
                                .where('name', isEqualTo: box.read('name'))
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 5),
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
                                              text: data.docs[index]
                                                  ['violation'],
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
          }),
    );
  }
}
