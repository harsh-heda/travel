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
    try {
      String pid = postCollection.doc().id;
      await postCollection.doc(pid).set({
        'to': to,
        'from': from,
        'date': date,
        'time': time,
        'uid': uid,
        'pid': pid,
        'timestamp': Timestamp.now().toDate().toString()
      });
      return await postCollection.doc(pid).get();
    } catch (e) {
      print(e.toString());
      return null;
    }
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
          uid: doc.data()['uid'],
          pid: doc.data()['pid'],
          timestamp: doc.data()['timestamp']);
    }).toList();
  }

//stream of posts
  Stream<List<PostData>> get postData {
    return postCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  // current user post list from snapshot

  List<PostData> _currentUserPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostData(
          to: doc.data()['to'],
          from: doc.data()['from'],
          date: doc.data()['date'],
          time: doc.data()['time'],
          uid: doc.data()['uid'],
          pid: doc.data()['pid']);
    }).toList();
  }

  // current user stream of posts
  Stream<List<PostData>> get myPost {
    return postCollection
        .where('uid', isEqualTo: uid.toString())
        .snapshots()
        .map(_currentUserPostListFromSnapshot);
  }

  //  deleting user post
  Future<void> deletePost() async {
    return await postCollection
        .doc(uid)
        .delete()
        .then((value) => print("Post Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  // editing user post

  Future updatePost(String to, String from, String date, String time) {
    Map<String, String> values = new Map<String, String>();
    to.isEmpty ? print('no change') : values['to'] = to;
    from.isEmpty ? print('no change') : values['from'] = from;
    date.isEmpty ? print('no change') : values['date'] = date;
    time.isEmpty ? print('no change') : values['time'] = time;
    return postCollection
        .doc(uid)
        .update(values)
        .then((value) => print("Profile Updated"))
        .catchError((error) => print("Failed to update Profile: $error"));
  }
}
