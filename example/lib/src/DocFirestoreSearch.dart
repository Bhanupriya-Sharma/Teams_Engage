import 'package:cloud_firestore/cloud_firestore.dart';

class Document extends GetOptions {
  Future<QuerySnapshot> getData(String meetId, String pass) {
    return FirebaseFirestore.instance
        .collection('Meetings')
        .where('Password', isEqualTo: pass)
        .get();
  }

  ///Widget getData(String meetId, String pass){
  ///return StreamBuilder(
  ///stream: FirebaseFirestore.instance.collection(
}
