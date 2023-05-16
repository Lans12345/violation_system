import 'package:flutter/material.dart';

class VehicleRequestDialog extends StatelessWidget {
  final String name;

  final String vehicleType;
  final String vehicleTemplateNumber;

  final String returnDateAndTime;
  final String vehicleDescription;
  final String licenseNumber;
  final String violation;

  const VehicleRequestDialog({
    super.key,
    required this.name,
    required this.violation,
    required this.licenseNumber,
    required this.vehicleDescription,
    required this.vehicleType,
    required this.vehicleTemplateNumber,
    required this.returnDateAndTime,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Vehicle Request Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInfoRow(Icons.warning, 'Violation', violation),
          _buildInfoRow(Icons.person, 'Name', name),
          _buildInfoRow(Icons.directions_car, 'Vehicle Type', vehicleType),
          _buildInfoRow(
              Icons.numbers, 'Vehicle Description', vehicleDescription),
          _buildInfoRow(Icons.numbers, 'Plate Number', vehicleTemplateNumber),
          _buildInfoRow(
              Icons.format_list_numbered, 'License Number', licenseNumber),
          _buildInfoRow(Icons.timelapse, 'Date and Time', returnDateAndTime),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData iconData, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(iconData, color: Colors.blue),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(label, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4.0),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
