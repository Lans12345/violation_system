import 'package:flutter/material.dart';
import 'package:violation_system/widgets/drawer_widget.dart';
import 'package:violation_system/widgets/text_widget.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xff6571E0),
        title: TextBold(text: 'T & VR', fontSize: 24, color: Colors.white),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png'),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextBold(text: 'Welcome Admin!', fontSize: 32, color: Colors.black),
            const SizedBox(
              height: 50,
            ),
            TextRegular(
                text: 'Recent Activities', fontSize: 18, color: Colors.grey),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Card(
                        child: ListTile(
                          title: TextBold(
                              text: 'Activity Title',
                              fontSize: 14,
                              color: Colors.black),
                          subtitle: TextRegular(
                              text: 'Name of Officer Incharge',
                              fontSize: 11,
                              color: Colors.grey),
                          trailing: TextRegular(
                              text: 'Date and Time',
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
