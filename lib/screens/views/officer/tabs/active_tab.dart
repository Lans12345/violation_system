import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/services/add_notif.dart';
import 'package:violation_system/widgets/toast_widget.dart';

import '../../../../widgets/text_widget.dart';

class ActiveTab extends StatelessWidget {
  const ActiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Officers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Container(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextBold(
                text: 'Active Officers', fontSize: 24, color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Officers')
                    .where('isActive', isEqualTo: true)
                    .where('id',
                        isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
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

                  final officerData = snapshot.requireData;
                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemCount: officerData.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.online_prediction_rounded,
                                  color: Colors.green,
                                ),
                                title: TextBold(
                                    text: officerData.docs[index]['name'],
                                    fontSize: 14,
                                    color: Colors.black),
                                trailing: SizedBox(
                                  width: 50,
                                  child: StreamBuilder<DocumentSnapshot>(
                                      stream: userData,
                                      builder: (context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                              child: Text('Loading'));
                                        } else if (snapshot.hasError) {
                                          return const Center(
                                              child:
                                                  Text('Something went wrong'));
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        dynamic data = snapshot.data;
                                        return IconButton(
                                          onPressed: () {
                                            showToast(
                                                "You've just waived at Officer ${officerData.docs[index]['name']}");
                                            addNotif(
                                                data['name'],
                                                officerData.docs[index]['id'],
                                                'Officer ${data['name']} waived at you!');
                                          },
                                          icon: const Icon(
                                            Icons.waving_hand_rounded,
                                            color: Colors.amber,
                                          ),
                                        );
                                      }),
                                ),
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
