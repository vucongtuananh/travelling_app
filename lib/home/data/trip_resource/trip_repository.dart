import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';

class TripRepository {
  final FireStoreData fireStoreData;
  List<Trip> _listTrip = [];
  TripRepository({required this.fireStoreData});

  List<Trip> get listTrip => _listTrip;

  Future<void> getListTrip() async {
    _listTrip = await fireStoreData.getData();
  }

  Future<void> addFavoriteTrip(String id) async {}
}
