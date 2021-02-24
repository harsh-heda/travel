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
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        firstName: snapshot.data()['firstName'],
        lastName: snapshot.data()['lastName'],
        uid: snapshot.data()['uid']);
  }

  //stream of users
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // post list from snapshot

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

//stream of posts
  Stream<List<PostData>> get postData {
    return postCollection.snapshots().map(_postListFromSnapshot);
  }

  // current user post list from snapshot

  List<PostData> _currentUserPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostData(
          to: doc.data()['to'],
          from: doc.data()['from'],
          date: doc.data()['date'],
          time: doc.data()['time'],
          uid: doc.data()['uid']);
    }).toList();
  }

  // current user stream of posts
  Stream<List<PostData>> get myPost {
    return postCollection
        .where('uid', isEqualTo: uid.toString())
        .snapshots()
        .map(_currentUserPostListFromSnapshot);
  }
}
