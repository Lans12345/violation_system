import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addNotif(myName, officerId, message) async {
  final docUser = FirebaseFirestore.instance.collection('Notifs').doc();

  final json = {
    'myName': myName,
    'myId': FirebaseAuth.instance.currentUser!.uid,
    'officerId': officerId,
    'message': message,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
