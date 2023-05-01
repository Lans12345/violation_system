import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:violation_system/widgets/toast_widget.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/text_widget.dart';
import '../../../../widgets/textfield_widget.dart';

class LicenseTab extends StatefulWidget {
  final userDetails;

  const LicenseTab({super.key, required this.userDetails});

  @override
  State<LicenseTab> createState() => _LicenseTabState();
}

class _LicenseTabState extends State<LicenseTab> {
  final platenumberController = TextEditingController();
  final vehicledescriptionController = TextEditingController();
  final locationController = TextEditingController();
  final violationController = TextEditingController();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

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
                        ageController.clear();
                        nameController.clear();
                        violationController.clear();
                        genderController.clear();
                        Navigator.of(context).pop(true);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: TextBold(
                                    text: 'Violation Added!',
                                    fontSize: 18,
                                    color: Colors.black),
                                content: StatefulBuilder(
                                    builder: (context, setState) {
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: DropdownButton(
                                                dropdownColor: Colors.white,
                                                focusColor: Colors.white,
                                                value: _dropValue1,
                                                items: [
                                                  for (int i = 0;
                                                      i < vehicles.length;
                                                      i++)
                                                    DropdownMenuItem(
                                                      enabled: false,
                                                      onTap: (() {
                                                        vehicle = vehicles[i];
                                                      }),
                                                      value: i,
                                                      child: Row(
                                                        children: [
                                                          TextRegular(
                                                              text:
                                                                  '${vehicles[i]}',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                                onChanged: ((value) {
                                                  setState(() {
                                                    _dropValue1 = int.parse(
                                                        value.toString());
                                                  });
                                                })),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint: 'Name of person',
                                            enabled: false,
                                            label: 'Name',
                                            controller: nameController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint: 'Gender of person',
                                            enabled: false,
                                            label: 'Gender',
                                            controller: genderController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint: 'Age of person',
                                            enabled: false,
                                            label: 'Age',
                                            controller: ageController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint: 'Violation Commited',
                                            enabled: false,
                                            label: 'Violation/s',
                                            controller: violationController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint:
                                                'License Number of the Person',
                                            enabled: false,
                                            label: 'License Number',
                                            controller: licenseController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint: 'Plate Number of the vehicle',
                                            enabled: false,
                                            label: 'Plate Number',
                                            controller: platenumberController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint: 'Vehicle Description',
                                            enabled: false,
                                            label: 'Vehicle Description',
                                            controller:
                                                vehicledescriptionController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFieldWidget(
                                            hint:
                                                'Location where the violation commited',
                                            enabled: false,
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
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      showToast('Violation Added!');
                                    },
                                    child: TextRegular(
                                        text: 'Close',
                                        color: Colors.grey,
                                        fontSize: 12),
                                  ),
                                ],
                              );
                            });
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
        title: TextBold(
            text: widget.userDetails['licenseNumber'],
            fontSize: 24,
            color: Colors.white),
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
                  child: TextBold(
                      text: widget.userDetails['name'],
                      fontSize: 18,
                      color: Colors.black),
                ),
                Center(
                    child: TextBold(
                        text:
                            '${widget.userDetails['gender']} | ${widget.userDetails['age']}',
                        fontSize: 16,
                        color: Colors.black)),
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
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Violations')
                        .where('licenseNumber',
                            isEqualTo: widget.userDetails['licenseNumber'])
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return SizedBox(
                        height: 280,
                        child: ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Card(
                                child: ListTile(
                                  title: TextBold(
                                      text: data.docs[index]['violation'],
                                      fontSize: 14,
                                      color: Colors.black),
                                  subtitle: TextRegular(
                                      text: data.docs[index]['location'],
                                      fontSize: 11,
                                      color: Colors.grey),
                                  trailing: TextRegular(
                                      text: DateFormat.yMMMd().add_jm().format(
                                          data.docs[index]['dateTime']
                                              .toDate()),
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
