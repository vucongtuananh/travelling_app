import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  final String imgPath;
  final String title;
  final double rate;
  final String location;
  final double price;
  final String id;
  final String describe;
  final bool isFavorite;

  Trip({
    required this.isFavorite,
    required this.imgPath,
    required this.title,
    required this.rate,
    required this.location,
    required this.price,
    required this.describe,
    required this.id,
  });

  factory Trip.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    double getPrice(dynamic price) {
      if (price.runtimeType is String) {
        return double.parse(price);
      } else {
        return price.toDouble();
      }
    }

    return Trip(
      isFavorite: data['isFavorite'],
      id: data['id'],
      describe: data['describe'],
      imgPath: data['img'],
      location: data['location'],
      price: getPrice(data['price']),
      rate: data['rate'],
      title: data['title'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "describe": describe,
      "img": imgPath,
      'location': location,
      'price': price,
      'title': title,
      'rate': rate,
    };
  }
}
