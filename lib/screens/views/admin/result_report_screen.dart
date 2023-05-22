import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../widgets/text_widget.dart';
import '../../../widgets/view_violation_dialog.dart';

class ResultReportsScreen extends StatelessWidget {
  final data;

  const ResultReportsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextBold(text: data['name'], fontSize: 18, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Violations')
              .where('officerId', isEqualTo: data.id)
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
            return SizedBox(
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
                                return ViolationDialog(data: data.docs[index]);
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
                            text: DateFormat.yMMMd()
                                .add_jm()
                                .format(data.docs[index]['dateTime'].toDate()),
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
