import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:violation_system/widgets/text_widget.dart';

class ViolationDialog extends StatelessWidget {
  late dynamic data;

  final box = GetStorage();

  ViolationDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: contentBox(context),
      actions: [
        box.read('role') == 'Admin'
            ? TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('Violations')
                      .doc(data.id)
                      .delete();
                  Navigator.pop(context);
                },
                child: TextBold(
                  text: 'Delete',
                  fontSize: 14,
                  color: Colors.red,
                ),
              )
            : const SizedBox(),
        box.read('role') == 'Driver'
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: TextBold(
                              text: 'QR Code for this Violation',
                              fontSize: 18,
                              color: Colors.black),
                          content: SizedBox(
                            height: 300,
                            width: 300,
                            child: QrImage(
                              data: data['id'],
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                                child: TextRegular(
                                    text: 'Close',
                                    fontSize: 14,
                                    color: Colors.black)),
                          ],
                        );
                      }));
                },
                child: TextBold(
                  text: 'View QR Code',
                  fontSize: 14,
                  color: Colors.blue,
                ),
              )
            : const SizedBox()
      ],
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Violation Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildInfoRow('Car:', data['car']),
                buildInfoRow('Name:', data['name']),
                buildInfoRow('Gender:', data['gender']),
                buildInfoRow('Age:', data['age'].toString()),
                buildInfoRow('Violation:', data['violation']),
                buildInfoRow('Fine:', '₱${data['fee']}'),
                buildInfoRow('License Number:', data['licenseNumber']),
                buildInfoRow('Plate Number:', data['plateNumber']),
                buildInfoRow(
                    'Vehicle Description:', data['vehicleDescription']),
                buildInfoRow('Location:', data['location']),
                const SizedBox(height: 16),
                buildImageRow('Evidence:', data['evidence']),
                buildImageRow('Owner:', data['owner']),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
          ),
        ),
      ],
    );
  }

  Widget buildImageRow(String label, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }
}
