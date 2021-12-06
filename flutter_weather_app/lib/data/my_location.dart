import 'package:geolocator/geolocator.dart';

class MyLocation {
  double latitude2 = 0;
  double longitude2 = 0;

  Future<void> getMyCurrentLocation() async {
    try {
      //위도와 경도를 position 변수에 할당. async 방식으로 작동함.
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      //위도 경도 분리해서 출력
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print('위도 : $latitude2');
      print('경도 : $longitude2');
    } catch (e) {
      print('There was a problem with the internet connection.');
    }
  }
}
