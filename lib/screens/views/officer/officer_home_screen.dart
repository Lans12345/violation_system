import 'package:flutter/material.dart';

import '../../../widgets/text_widget.dart';

class OfficerHomeScreen extends StatelessWidget {
  const OfficerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: const Color(0xff6571E0),
        title: TextBold(text: 'T & VR', fontSize: 24, color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextBold(
                text: 'Welcome Offier\n      John Doe!',
                fontSize: 32,
                color: Colors.black),
            const SizedBox(
              height: 50,
            ),
            TextRegular(
                text: 'Violation Records', fontSize: 18, color: Colors.grey),
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
            ),
          ],
        ),
      ),
    );
  }
}
