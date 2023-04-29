import 'package:flutter/material.dart';

import '../../../../widgets/text_widget.dart';
import '../../../../widgets/textfield_widget.dart';

class LicenseTab extends StatefulWidget {
  const LicenseTab({super.key});

  @override
  State<LicenseTab> createState() => _LicenseTabState();
}

class _LicenseTabState extends State<LicenseTab> {
  final platenumberController = TextEditingController();
  final vehicledescriptionController = TextEditingController();
  final locationController = TextEditingController();
  final violationController = TextEditingController();

  var _dropValue1 = 0;

  List vehicles = ['Car', 'Motorcycle', 'Bus', 'Jeep', 'Van'];

  late String vehicle = 'Car';

  final licenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6571E0),
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: TextBold(
                      text: 'Adding Violation',
                      fontSize: 18,
                      color: Colors.black),
                  content: StatefulBuilder(builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextRegular(
                                text: 'Vehicle Type',
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 300,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  focusColor: Colors.white,
                                  value: _dropValue1,
                                  items: [
                                    for (int i = 0; i < vehicles.length; i++)
                                      DropdownMenuItem(
                                        onTap: (() {
                                          vehicle = vehicles[i];
                                        }),
                                        value: i,
                                        child: Row(
                                          children: [
                                            TextRegular(
                                                text: '${vehicles[i]}',
                                                fontSize: 14,
                                                color: Colors.black),
                                          ],
                                        ),
                                      ),
                                  ],
                                  onChanged: ((value) {
                                    setState(() {
                                      _dropValue1 = int.parse(value.toString());
                                    });
                                  })),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              label: 'Violation/s',
                              controller: violationController),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              label: 'License Number',
                              controller: licenseController),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              label: 'Plate Number',
                              controller: platenumberController),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              label: 'Vehicle Description',
                              controller: vehicledescriptionController),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              label: 'Location',
                              controller: locationController),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  }),
                  actions: [
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: TextRegular(
                          text: 'Close', color: Colors.grey, fontSize: 12),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        locationController.clear();
                        vehicledescriptionController.clear();
                        platenumberController.clear();
                        Navigator.of(context).pop(true);
                      },
                      child: TextBold(
                          text: 'Continue', color: Colors.black, fontSize: 14),
                    ),
                  ],
                );
              });
        },
      ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child:
                      TextBold(text: 'Name', fontSize: 18, color: Colors.black),
                ),
                Center(
                    child: TextBold(
                        text: 'Gender | Age',
                        fontSize: 16,
                        color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                TextRegular(
                    text: 'Contact Number: Contact Number',
                    fontSize: 14,
                    color: Colors.grey),
                const SizedBox(
                  height: 10,
                ),
                TextRegular(
                    text: 'Address: Address', fontSize: 14, color: Colors.grey),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextBold(
                      text: 'Violation Records',
                      fontSize: 18,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 280,
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
                                text: 'Location where the violation commited',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
