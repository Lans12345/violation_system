import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/text_widget.dart';

class OfficerStatusScreen extends StatefulWidget {
  const OfficerStatusScreen({super.key});

  @override
  State<OfficerStatusScreen> createState() => _OfficerStatusScreenState();
}

class _OfficerStatusScreenState extends State<OfficerStatusScreen> {
  String dropdownValue = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(
            text: 'Officers Status', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: const SizedBox(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Active', 'Inactive']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextRegular(
                            text: 'Status: $value',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                              text: 'Officer Name',
                              fontSize: 14,
                              color: Colors.black),
                          trailing: TextRegular(
                              text: 'Status', fontSize: 12, color: Colors.grey),
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
