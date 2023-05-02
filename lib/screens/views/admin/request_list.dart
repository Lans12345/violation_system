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
        backgroundColor: const Color.fromARGB(255, 240, 23, 95),
        title: TextBold(
            text: 'Request for Approval', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: DataTable(columns: [
          DataColumn(
            label: TextBold(text: 'Officer', fontSize: 16, color: Colors.black),
          ),
          DataColumn(
            label: TextBold(text: 'Details', fontSize: 16, color: Colors.black),
          ),
          DataColumn(
            label: TextBold(text: '', fontSize: 0, color: Colors.black),
          ),
        ], rows: [
          for (int i = 0; i < 100; i++)
            DataRow(cells: [
              DataCell(
                TextBold(
                    text: 'Name of Officer', fontSize: 12, color: Colors.grey),
              ),
              DataCell(
                TextRegular(
                    text: 'Details of Request',
                    fontSize: 12,
                    color: Colors.grey),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_box_outlined,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.highlight_remove_outlined,
                          color: Colors.red,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])
        ]),
      ),
    );
  }
}
