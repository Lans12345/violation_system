import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/widgets/toast_widget.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(
            text: 'Request for Approval', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Violations')
                .where('status', isEqualTo: 'Pending')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return DataTable(columns: [
                DataColumn(
                  label:
                      TextBold(text: 'Name', fontSize: 16, color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(
                      text: 'Violation', fontSize: 16, color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(text: '', fontSize: 0, color: Colors.black),
                ),
              ], rows: [
                for (int i = 0; i < data.docs.length; i++)
                  DataRow(cells: [
                    DataCell(
                      TextBold(
                          text: data.docs[i]['name'],
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    DataCell(
                      TextRegular(
                          text: data.docs[i]['violation'],
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    DataCell(
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('Violations')
                                    .doc(data.docs[i].id)
                                    .update({'status': 'Accepted'});
                                showToast('Request accepted!');
                              },
                              icon: const Icon(
                                Icons.check_box_outlined,
                                color: Colors.green,
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('Violations')
                                    .doc(data.docs[i].id)
                                    .update({'status': 'Rejected'});
                                showToast('Request rejected!');
                              },
                              icon: const Icon(
                                Icons.highlight_remove_outlined,
                                color: Colors.red,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])
              ]);
            }),
      ),
    );
  }
}
