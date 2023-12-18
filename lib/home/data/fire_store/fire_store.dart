import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/own/data/user_model.dart';

final firebaseStorage = FirebaseFirestore.instance;

class FireStoreData {
  final String currentUserId;
  FireStoreData({required this.currentUserId});

  postUser({required String name, required String email, required String password}) async {
    await firebaseStorage.collection("user").doc(currentUserId).set({"user-name": name, "email": email, "password": password});
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
    await firebaseStorage.collection("user").doc(currentUserId).collection("trip").add({
      "describe": describe,
      "img": img,
      "location": location,
      "price": price,
      "rate": rate,
      "title": title,
      "isFavorite": false,
      "id": id1,
    });
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

  Future<UserModel?> getUserInfor() async {
    late UserModel user;
    await firebaseStorage.collection("user").doc(currentUserId).get().then((value) {
      user = UserModel.fromFireStore(value);
    });
    return user;
  }
}
