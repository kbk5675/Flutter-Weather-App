import 'dart:convert'; //jsonDecode 사용가능.
import 'package:http/http.dart' as http;

class NetWork {
  final String url; //url 이라는 속성 생성.
  final String url2;
  NetWork(this.url, this.url2); //생성자를 생성해 속성을 전달받을 수 있게 해줌.

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    }
  }
}
