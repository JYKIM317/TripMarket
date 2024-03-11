//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:trip_market/properties.dart';

class GeoLocatorRemote {
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }
}

class GoogleMapRemote {
  Future<dynamic> getPlaceAddress(
      {required double lat, required double lng}) async {
    String gMapApiKey = Apikeys().gMapApiKey;
    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$gMapApiKey';
    var response = await http.get(Uri.parse(url));

    return response;
  }
}
