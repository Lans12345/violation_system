import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addViolation(car, name, gender, age, violation, licenseNumber,
    plateNumber, vehicleDescription, location, lat, long) async {
  final docUser = FirebaseFirestore.instance.collection('Violations').doc();

  final json = {
    'name': name,
    'gender': gender,
    'car': car,
    'age': age,
    'violation': violation,
    'licenseNumber': licenseNumber,
    'plateNumber': plateNumber,
    'vehicleDescription': vehicleDescription,
    'location': location,
    'lat': lat,
    'long': long,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'officerId': FirebaseAuth.instance.currentUser!.uid
  };

  await docUser.set(json);
}
