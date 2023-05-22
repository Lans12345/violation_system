import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/screens/views/admin/result_report_screen.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final scroll = ScrollController();

  String dropdownValue = 'Weekly';
  String dropdownValue1 = 'Paid';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: TextBold(text: 'Reports', fontSize: 18, color: Colors.white),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Officers').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
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
              return GridView.builder(
                itemCount: data.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ResultReportsScreen(data: data.docs[index])));
                      },
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: CircleAvatar(
                                minRadius: 40,
                                maxRadius: 40,
                                backgroundImage:
                                    NetworkImage(data.docs[index]['profile']),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextBold(
                              text: data.docs[index]['name'],
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            TextRegular(
                              text: data.docs[index]['contactNumber'],
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
