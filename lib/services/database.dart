import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel/models/users.dart';
import 'package:travel/models/posts.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  Future updateUserProfileData(
      String firstName, String lastName, String uid) async {
    return await userCollection
        .doc(uid)
        .set({'firstName': firstName, 'lastName': lastName, 'uid': uid});
  }

  Future updateUserTravelData(
      String to, String from, String date, String time, String uid) async {
    return await postCollection
        .add({'to': to, 'from': from, 'date': date, 'time': time, 'uid': uid});
  }

  // user list from snapshot
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
          firstName: doc.data()['firstName'],
          lastName: doc.data()['lastName'],
          uid: doc.data()['uid']);
    }).toList();
  }

  //stream of users
  Stream<List<UserData>> get userData {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  List<PostData> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostData(
          to: doc.data()['to'],
          from: doc.data()['from'],
          date: doc.data()['date'],
          time: doc.data()['time'],
          uid: doc.data()['uid']);
    }).toList();
  }

  Stream<List<PostData>> get postData {
    return postCollection.snapshots().map(_postListFromSnapshot);
  }
}
