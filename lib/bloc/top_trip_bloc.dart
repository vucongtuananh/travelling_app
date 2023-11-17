import 'package:travelling_app/models/group_trip.dart';
import 'package:travelling_app/models/trip.dart';

List<Trip> listTrips = [
  Trip(
      imgPath: "location_2.png",
      title: "RedFish Lake",
      rate: 4.5,
      location: "Idaho",
      price: 50,
      id: 1,
      describe:
          "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,Idaho, just south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area."),
  Trip(
      imgPath: "location_2.png",
      title: "Maligne Lake",
      rate: 4.5,
      location: "Canada",
      price: 40,
      id: 2,
      describe:
          "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,Idaho, just south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area."),
  Trip(
      imgPath: "location_2.png",
      title: "RLake McDonald",
      rate: 4.5,
      location: "Canada",
      price: 40,
      id: 3,
      describe:
          "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,Idaho, just south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area."),
];

List<GroupTrip> listGroupTrips = [GroupTrip(id: "1", title: "Mountain Trip", name: "Seelisburg", location: "Norway", amount: 110, percent: 50)];
