import 'package:flutter/material.dart';

import '../../../../widgets/text_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final searchController = TextEditingController();

  String nameSearched = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 20,
            ),
            TextRegular(
                text: 'Violation Records', fontSize: 18, color: Colors.grey),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    nameSearched = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontFamily: 'QRegular'),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    )),
                controller: searchController,
              ),
            ),
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
