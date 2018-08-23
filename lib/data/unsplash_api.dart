import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchRandomImage(int w, int h) async {
  try{
    String url = "https://api.unsplash.com/photos/random/?client_id=76e62bf0e0f7a3ef905b0bd44e138584eeb96dbca3a85c950e8148785d133142&w=$w&h=$h&query=earth";
    print(url);
    final response =
    await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['urls']['custom'];
    } else {
      return null;
    }
  }catch(e){
    print(e);
    return null;
  }
}
