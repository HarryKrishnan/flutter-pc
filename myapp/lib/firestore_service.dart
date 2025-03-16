import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> fetchAndSetIam() async {
    DocumentSnapshot doc = await _db.collection('ec2ep').doc('ec211').get();
    return doc.exists ? doc['ec2'] as String : null;
  }
}