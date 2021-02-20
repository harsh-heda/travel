import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference travelCollection =
      FirebaseFirestore.instance.collection("travels");

  Future updateUserProfileData(String firstName, String lastName) async {
    return await travelCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future updateUserTravelData(String to, String from) async {
    return await travelCollection
        .doc(uid)
        .collection("travelPost")
        .doc(uid)
        .set({'to': to, 'from': from});
  }
}
