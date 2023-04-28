import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
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
    );
  }
}
