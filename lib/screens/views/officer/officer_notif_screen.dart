import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../widgets/text_widget.dart';

class OfficerNotifScreen extends StatelessWidget {
  const OfficerNotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        title:
            TextBold(text: 'Notifications', fontSize: 24, color: Colors.white),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Notifs')
              .orderBy('dateTime', descending: true)
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
            return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.notifications_active_sharp),
                        title: TextBold(
                            text: data.docs[index]['message'],
                            fontSize: 14,
                            color: Colors.black),
                        subtitle: TextRegular(
                            text: DateFormat.yMMMd()
                                .add_jm()
                                .format(data.docs[index]['dateTime'].toDate()),
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
