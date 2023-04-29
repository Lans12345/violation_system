import 'package:flutter/material.dart';
import 'package:violation_system/widgets/text_widget.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextBold(
                      text: 'Name of Officer',
                      fontSize: 18,
                      color: Colors.black),
                ),
                Center(
                    child: TextBold(
                        text: 'Gender | Age',
                        fontSize: 16,
                        color: Colors.black)),
                const SizedBox(
                  height: 20,
                ),
                TextRegular(
                    text: 'Username: Username of Officer',
                    fontSize: 14,
                    color: Colors.grey),
                const SizedBox(
                  height: 10,
                ),
                TextRegular(
                    text: 'Contact Number: Contact Number of Officer',
                    fontSize: 14,
                    color: Colors.grey),
                const SizedBox(
                  height: 10,
                ),
                TextRegular(
                    text: 'Address: Address of Officer',
                    fontSize: 14,
                    color: Colors.grey),
                const SizedBox(
                  height: 10,
                ),
                TextRegular(
                    text: 'Status: Status of Officer (Active/Inactive)',
                    fontSize: 14,
                    color: Colors.grey),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextBold(
                      text: 'History Records',
                      fontSize: 18,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Card(
                          child: ListTile(
                            title: TextBold(
                                text: 'Name of Violation',
                                fontSize: 14,
                                color: Colors.black),
                            subtitle: TextRegular(
                                text: 'Person who commited the violation',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
