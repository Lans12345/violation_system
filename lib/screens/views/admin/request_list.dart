import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/widgets/toast_widget.dart';
import 'package:intl/intl.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/view_violation_dialog.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  final scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextBold(
            text: 'Request for Approval', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Violations')
                .where('status', isEqualTo: 'Pending')
                .where('paid', isEqualTo: false)
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
              return Scrollbar(
                controller: scroll,
                child: SingleChildScrollView(
                  controller: scroll,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(columns: [
                      DataColumn(
                        label: TextBold(
                            text: 'Name', fontSize: 16, color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: 'Violation',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: 'Officer Name',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: 'Date and Time',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: '', fontSize: 0, color: Colors.black),
                      ),
                    ], rows: [
                      for (int i = 0; i < data.docs.length; i++)
                        DataRow(cells: [
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ViolationDialog(
                                          data: data.docs[i]);
                                    });
                              },
                              child: TextBold(
                                  text: data.docs[i]['name'],
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ViolationDialog(
                                          data: data.docs[i]);
                                    });
                              },
                              child: TextRegular(
                                  text: data.docs[i]['violation'],
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ViolationDialog(
                                          data: data.docs[i]);
                                    });
                              },
                              child: TextRegular(
                                  text: data.docs[i]['myName'],
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ViolationDialog(
                                          data: data.docs[i]);
                                    });
                              },
                              child: TextRegular(
                                  text: DateFormat.yMMMd().add_jm().format(
                                      data.docs[i]['dateTime'].toDate()),
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Violations')
                                          .doc(data.docs[i].id)
                                          .update({'status': 'Accepted'});
                                      showToast('Violation accepted!');
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
                                      showToast('Violation rejected!');
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
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
