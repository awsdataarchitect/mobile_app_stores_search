library mobile_app_stores_search;

import 'dart:convert';
import 'package:http/http.dart' as http;

/// A widget that returns all apps details of Apple Store and Google Play
/// Store via API, according to the query & store you selected.
class MobileAppStoresSearch {
  final String apiKey;
  final String uuid;
  final String apiUrl = "https://api.waltsoft.net/app-store-info";

  /// Sets up Mobile App Store Search with your API key and an unique user id.
  ///
  /// You can get both [apiKey] and [uuid] for free, here : http://www.waltsoft-inc.com/
  ///
  /// Both [apiKey] and [uuid] are required.
  MobileAppStoresSearch({
    required this.apiKey,
    required this.uuid,
  });

  /// Returns list of apps in JSON Map\<key, value> format, according to the search query & store you selected.
  ///
  /// - when no app is found, the null is returned.
  ///
  /// [searchQuery]
  ///  - pass app name, seller/developer name to this parameter.
  ///
  /// [searchInAppleStore]
  ///  - pass true if you want to search in Apple Store.
  ///  - pass false if you want to search in Google Play Store.
  ///  - by default is set to true
  Future<dynamic> searchAppInStoreResponseJson(
      {required String searchQuery, bool searchInAppleStore = true}) async {
    if (searchQuery.isNotEmpty) {
      //getting resopnse
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            "x-api-key": apiKey,
          },
          body: json.encode({
            "query": searchQuery,
            "store": searchInAppleStore ? 'apple' : 'google',
            "uuid": uuid
          }));
      if (response.statusCode == 200) {
        var r = response.body.replaceAll('True', 'true');
        r = r.replaceAll('False', 'false');

        var jsonData = json.decode(r);

        return jsonData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
