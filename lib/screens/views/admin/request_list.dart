import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xff6571E0),
        title: TextBold(
            text: 'Request for Approval', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
    );
  }
}
