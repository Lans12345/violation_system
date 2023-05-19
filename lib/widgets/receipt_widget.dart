import 'package:flutter/material.dart';

class ReceiptWidget extends StatelessWidget {
  final dynamic data;

  const ReceiptWidget({super.key, required this.data});

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Thank you for\nyour cooperation!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Screenshot your receipt',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
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
