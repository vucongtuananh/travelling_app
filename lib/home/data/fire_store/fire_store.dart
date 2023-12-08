import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelling_app/home/data/models/trip.dart';

final firebaseStorage = FirebaseFirestore.instance;

class FireStoreData {
  final String currentUserId;
  FireStoreData({required this.currentUserId});

  postUser({required String name, required String email, required String password}) async {
    await firebaseStorage.collection("user").doc(currentUserId).set({"user-name": name, "email": email, "password": password});
  }

  // postData({
  //   required String describe,
  //   required String img,
  //   required String location,
  //   required double price,
  //   required double rate,
  //   required String title,
  //   required String id1,
  //   required String id2,
  //   required String id3,
  //   required String id4,
  // }) async {
  //   await firebaseStorage.collection("user").doc(currentUserId).collection("trip").add({
  //     "trip": [
  //       {
  //         "describe": describe,
  //         "img": img,
  //         "location": location,
  //         "price": price,
  //         "rate": rate,
  //         "title": title,
  //         "isFavorite": false,
  //         "id": id1,
  //       },
  //       {
  //         "describe": describe,
  //         "img": img,
  //         "location": location,
  //         "price": price,
  //         "rate": rate,
  //         "title": title,
  //         "isFavorite": false,
  //         "id": id2,
  //       },
  //       {
  //         "describe": describe,
  //         "img": img,
  //         "location": location,
  //         "price": price,
  //         "rate": rate,
  //         "title": title,
  //         "isFavorite": false,
  //         "id": id3,
  //       },
  //       {
  //         "describe": describe,
  //         "img": img,
  //         "location": location,
  //         "price": price,
  //         "rate": rate,
  //         "title": title,
  //         "isFavorite": false,
  //         "id": id4,
  //       }
  //     ]
  //   });
  // }

  Future<List<Trip>> getData() async {
    final List<Trip> listData = [];
    await firebaseStorage.collection("user").doc(currentUserId).collection("trip").get().then((value) {
      for (var a in value.docs) {
        for (int i = 0; i < a.data()['trip'].length; i++) {
          listData.add(Trip.fromFirestore(a.data()['trip'][i]));
        }
      }
    });
    return listData;
  }

  // favoriteData(Trip trip) async {
  //   await firebaseStorage.collection("user").doc(currentUserId).collection("trip").doc().
  // }
}
