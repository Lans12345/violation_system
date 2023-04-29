import 'package:cloud_firestore/cloud_firestore.dart';

Future addAccount(String username, String name, String password,
    String contactNumber, String gender, String age, String address, id) async {
  final docUser = FirebaseFirestore.instance.collection('Officers').doc(id);

  final json = {
    'name': name,
    'username': username,
    'password': password,
    'contactNumber': contactNumber,
    'gender': gender,
    'age': age,
    'address': address,
    'id': docUser.id,
    'isActive': false,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
