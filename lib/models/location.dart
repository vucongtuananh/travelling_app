import 'package:travelling_app/models/tour_guide.dart';

class Location {
  final String title;
  final double distance;
  final String image;
  final String id;
  final String imageDetail;
  final String describe;
  final String titleDetail;
  final double rate;
  final TourGuide tourGuide;

  const Location(
      {required this.title,
      required this.distance,
      required this.image,
      required this.id,
      required this.imageDetail,
      required this.describe,
      required this.titleDetail,
      required this.rate,
      required this.tourGuide});
}
