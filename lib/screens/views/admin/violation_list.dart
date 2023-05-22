import 'package:flutter/material.dart';
import 'package:violation_system/screens/views/officer/tabs/home_tab.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class ViolationListScreen extends StatelessWidget {
  const ViolationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:
            TextBold(text: 'Violation List', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: const HomeTab(),
    );
  }
}
