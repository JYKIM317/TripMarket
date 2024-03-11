import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:trip_market/data/source/remote/location/location_remote.dart';
import 'dart:convert';

class LocationRepository {
  Future<String> getCurrentNation() async {
    String nation = '';
    Position position = await GeoLocatorRemote().getCurrentLocation();
    double lat = position.latitude;
    double lng = position.longitude;
    print('lat : $lat, lng : $lng');

    http.Response response =
        await GoogleMapRemote().getPlaceAddress(lat: lat, lng: lng);
    print('get address response : $response');
    var currentLocationData = jsonDecode(response.body);

    List<dynamic> addressComponents =
        currentLocationData['results'][0]['address_components'];
    for (var component in addressComponents) {
      List<dynamic> componentType = component['types'];
      if (componentType.contains('country')) {
        nation = component['long_name'];
      }
    }

    return nation;
  }
}
