class Trip {
  final String imgPath;
  final String title;
  final double rate;
  final String location;
  final double price;
  final int id;
  final String describe;
  bool isFavorite;

  Trip(
      {required this.id,
      required this.imgPath,
      required this.title,
      required this.rate,
      required this.location,
      required this.price,
      required this.describe,
      this.isFavorite = false});
}
