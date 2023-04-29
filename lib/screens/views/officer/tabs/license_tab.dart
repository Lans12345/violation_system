import 'package:flutter/material.dart';

import '../../../../widgets/text_widget.dart';

class LicenseTab extends StatelessWidget {
  const LicenseTab({super.key});

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
        backgroundColor: const Color(0xff6571E0),
        title:
            TextBold(text: 'License Number', fontSize: 24, color: Colors.white),
        centerTitle: true,
      ),
    );
  }
}
