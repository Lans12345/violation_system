import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:violation_system/widgets/text_widget.dart';
import 'package:violation_system/widgets/textfield_widget.dart';
import 'package:violation_system/widgets/toast_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import '../services/add_violation.dart';
import 'dart:io';

class AddViolationDialog extends StatefulWidget {
  const AddViolationDialog({super.key});

  @override
  State<AddViolationDialog> createState() => _AddViolationDialogState();
}

class _AddViolationDialogState extends State<AddViolationDialog> {
  late String fileName = '';

  late File imageFile;
  late String fileName1 = '';

  late File imageFile1;

  late String imageEvidence = '';
  late String imageOwner = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Images/$fileName')
            .putFile(imageFile);
        imageEvidence = await firebase_storage.FirebaseStorage.instance
            .ref('Images/$fileName')
            .getDownloadURL();

        setState(() {});

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> uploadPicture1(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName1 = path.basename(pickedImage.path);
      imageFile1 = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Images/$fileName1')
            .putFile(imageFile1);
        imageOwner = await firebase_storage.FirebaseStorage.instance
            .ref('Images/$fileName1')
            .getDownloadURL();

        setState(() {});

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  final platenumberController = TextEditingController();
  final vehicledescriptionController = TextEditingController();
  final locationController = TextEditingController();
  final licenseController = TextEditingController();
  final violationController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  var _dropValue1 = 0;

  List vehicles = ['Car', 'Motorcycle', 'Bus', 'Jeep', 'Van'];

  late String vehicle = 'Car';
  @override
  Widget build(BuildContext context) {
    print(imageEvidence);
    return AlertDialog(
      title:
          TextBold(text: 'Adding Violation', fontSize: 18, color: Colors.black),
      content: StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextRegular(
                    text: 'Picture of Evidence',
                    fontSize: 12,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  uploadPicture('camera');
                },
                child: imageEvidence == ''
                    ? Container(
                        width: 300,
                        height: 150,
                        color: Colors.black,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageEvidence),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextRegular(
                    text: "Picture of owner's license",
                    fontSize: 12,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  uploadPicture1('camera');
                },
                child: imageOwner == ''
                    ? Container(
                        width: 300,
                        height: 150,
                        color: Colors.black,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageOwner),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextRegular(
                    text: 'Vehicle Type', fontSize: 12, color: Colors.black),
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
              TextFieldWidget(label: 'Name', controller: nameController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(label: 'Gender', controller: genderController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(label: 'Age', controller: ageController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  label: 'Violation/s', controller: violationController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  label: 'License Number', controller: licenseController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  label: 'Plate Number', controller: platenumberController),
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
                  label: 'Location', controller: locationController),
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
          child: TextRegular(text: 'Close', color: Colors.grey, fontSize: 12),
        ),
        MaterialButton(
          onPressed: () async {
            Navigator.of(context).pop();
            addViolation(
                vehicle,
                nameController.text,
                genderController.text,
                ageController.text,
                violationController.text,
                licenseController.text,
                platenumberController.text,
                vehicledescriptionController.text,
                locationController.text,
                imageEvidence,
                imageOwner);
            locationController.clear();
            vehicledescriptionController.clear();
            platenumberController.clear();
            ageController.clear();
            nameController.clear();
            violationController.clear();
            genderController.clear();
            showToast('Violation Added! Waiting for confirmation');
          },
          child: TextBold(text: 'Continue', color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }
}
