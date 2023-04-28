import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xff6571E0),
        title: TextBold(
            text: 'Manage Accounts', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
    );
  }
}
