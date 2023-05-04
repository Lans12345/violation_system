import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class OfficerStatusScreen extends StatefulWidget {
  const OfficerStatusScreen({super.key});

  @override
  State<OfficerStatusScreen> createState() => _OfficerStatusScreenState();
}

class _OfficerStatusScreenState extends State<OfficerStatusScreen> {
  String dropdownValue = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(
            text: 'Officers Status', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                  items: <String>['Active', 'Inactive']
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
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: dropdownValue == 'Active'
                    ? FirebaseFirestore.instance
                        .collection('Officers')
                        .where('isActive', isEqualTo: true)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Officers')
                        .where('isActive', isEqualTo: false)
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
                                title: TextBold(
                                    text: officerData.docs[index]['name'],
                                    fontSize: 14,
                                    color: Colors.black),
                                trailing: TextRegular(
                                    text: dropdownValue,
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
