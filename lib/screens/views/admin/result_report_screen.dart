import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/fines.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/view_violation_dialog.dart';

class ResultReportsScreen extends StatefulWidget {
  final data;

  const ResultReportsScreen({super.key, required this.data});

  @override
  State<ResultReportsScreen> createState() => _ResultReportsScreenState();
}

class _ResultReportsScreenState extends State<ResultReportsScreen> {
  int day = 0;
  int month = 0;
  int year = 0;

  var _dropValue2 = 0;

  String violation = '';

  @override
  Widget build(BuildContext context) {
    print(violation);
    print(day);
    print(month);
    print(year);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextBold(
            text: widget.data['name'], fontSize: 18, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                setState(() {
                  day = selectedDate.day;
                  month = selectedDate.month;
                  year = selectedDate.year;
                });
              }
            },
            icon: const Icon(
              Icons.calendar_month,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: DropdownButton(
                  underline: const SizedBox(),
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  value: _dropValue2,
                  items: [
                    for (int i = 0; i < newList.length; i++)
                      DropdownMenuItem(
                        onTap: (() {
                          violation = newList[i]['offense'];
                        }),
                        value: i,
                        child: SizedBox(
                          width: 175,
                          child: TextRegular(
                              text: '${newList[i]['offense']}',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                  ],
                  onChanged: ((value) {
                    setState(() {
                      _dropValue2 = int.parse(value.toString());
                    });
                  })),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: violation != ''
                  ? year == 0
                      ? FirebaseFirestore.instance
                          .collection('Violations')
                          .where('officerId', isEqualTo: widget.data.id)
                          .where('violation', isEqualTo: violation)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Violations')
                          .where('officerId', isEqualTo: widget.data.id)
                          .where('violation', isEqualTo: violation)
                          .where('day', isEqualTo: day)
                          .where('month', isEqualTo: month)
                          .snapshots()
                  : year == 0
                      ? FirebaseFirestore.instance
                          .collection('Violations')
                          .where('officerId', isEqualTo: widget.data.id)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Violations')
                          .where('officerId', isEqualTo: widget.data.id)
                          .where('day', isEqualTo: day)
                          .where('month', isEqualTo: month)
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
                                  text: data.docs[index]['name'],
                                  fontSize: 14,
                                  color: Colors.black),
                              subtitle: TextRegular(
                                  text: data.docs[index]['violation'],
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
    );
  }
}
