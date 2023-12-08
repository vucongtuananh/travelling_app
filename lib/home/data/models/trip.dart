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
    Map<String, dynamic> snapshot,
  ) {
    final data = snapshot;
    return Trip(
      isFavorite: data['isFavorite'],
      id: data['id'],
      describe: data['describe'],
      imgPath: data['img'],
      location: data['location'],
      price: data['price'],
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
