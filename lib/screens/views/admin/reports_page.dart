import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/view_violation_dialog.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final scroll = ScrollController();

  String dropdownValue = 'Weekly';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(
            text: 'Request for Approval', fontSize: 18, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.print,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: const SizedBox(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Weekly', 'Monthly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextRegular(
                          text: 'Status: $value',
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: dropdownValue == 'Weekly'
                    ? FirebaseFirestore.instance
                        .collection('Violations')
                        .where('status', isEqualTo: 'Accepted')
                        .where('paid', isEqualTo: false)
                        .where('day', isEqualTo: DateTime.now().day.toString())
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Violations')
                        .where('status', isEqualTo: 'Accepted')
                        .where('paid', isEqualTo: false)
                        .where('month',
                            isEqualTo: DateTime.now().month.toString())
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
                  return Scrollbar(
                    controller: scroll,
                    child: SingleChildScrollView(
                      controller: scroll,
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(columns: [
                          DataColumn(
                            label: TextBold(
                                text: 'Name',
                                fontSize: 16,
                                color: Colors.black),
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
                            ])
                        ]),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
