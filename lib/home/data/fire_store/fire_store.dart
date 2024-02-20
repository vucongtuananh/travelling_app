import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/signup/data/models/user.dart';

final firebaseStorage = FirebaseFirestore.instance;

class FireStoreData {
  final String currentUserId;
  FireStoreData({required this.currentUserId});

  postUser({required String name, required String email, required String password, required String uid}) async {
    UserModel user = UserModel(email: email, uid: uid, name: name, pass: password, urlAvatar: '');
    await firebaseStorage.collection("user").doc(currentUserId).set(user.toJson());
  }

  postData({
    required String describe,
    required String img,
    required String location,
    required double price,
    required double rate,
    required String title,
    required String id1,
  }) async {
    Trip trip = Trip(
      isFavorite: false,
      imgPath: img,
      title: title,
      rate: rate,
      location: location,
      price: price,
      describe: describe,
      id: id1,
    );
    await firebaseStorage.collection("user").doc(currentUserId).collection("trip").doc(id1).set(
          trip.toFirestore(),
        );
  }

  Future<List<Trip>> getData() async {
    final List<Trip> listData = [];
    await firebaseStorage.collection("user").doc(currentUserId).collection("trip").get().then((value) {
      for (var a in value.docs) {
        listData.add(Trip.fromFirestore(a));
      }
    });
    return listData;
  }

  // favoriteData(Trip trip) async {
  //   await firebaseStorage.collection("user").doc(currentUserId).collection("trip").doc().
  // }
  Future<bool> toggleFavorite({required Trip trip}) async {
    final dataFromFavoriteList = await firebaseStorage.collection("user").doc(currentUserId).collection("favorite").doc(trip.id).get();
    if (dataFromFavoriteList.exists) {
      await firebaseStorage.collection("user").doc(currentUserId).collection("favorite").doc(trip.id).delete();
      return false;
    } else {
      await firebaseStorage.collection("user").doc(currentUserId).collection("favorite").doc(trip.id).set({
        "describe": trip.describe,
        "img": trip.imgPath,
        "location": trip.location,
        "price": trip.price,
        "rate": trip.rate,
        "title": trip.title,
        "isFavorite": false,
        "id": trip.id,
      });
      return true;
    }
  }

  Future<void> updateFavoriteTripStatus({required String id, required Map<String, dynamic> data}) async {
    await firebaseStorage.collection("user").doc(currentUserId).collection("trip").doc(id).update(data);
  }

  Future<bool> checkFavoriteTrip({required String idtrip}) async {
    final dataFromFavoriteList = await firebaseStorage.collection("user").doc(currentUserId).collection("favorite").doc(idtrip).get();
    if (dataFromFavoriteList.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Trip>> getFavoriteTripList() async {
    final List<Trip> listData = [];
    await firebaseStorage.collection("user").doc(currentUserId).collection("favorite").get().then((value) {
      for (var a in value.docs) {
        listData.add(Trip.fromFirestore(a));
      }
    });
    return listData;
  }
}
