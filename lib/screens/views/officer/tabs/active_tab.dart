import 'package:flutter/material.dart';

import '../../../../widgets/text_widget.dart';

class ActiveTab extends StatelessWidget {
  const ActiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextBold(
                text: 'Active Officers', fontSize: 24, color: Colors.black),
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
                          leading: const Icon(
                            Icons.online_prediction_rounded,
                            color: Colors.green,
                          ),
                          title: TextBold(
                              text: 'Name of Officer',
                              fontSize: 14,
                              color: Colors.black),
                          trailing: const Icon(
                            Icons.waving_hand_rounded,
                            color: Colors.amber,
                          ),
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
