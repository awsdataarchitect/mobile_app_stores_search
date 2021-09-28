# Mobile App Stores Search

Using Mobile App Stores Search library you can find all Android & iOS apps that match a given text query and Access data from Apple Store and Google Play Store via API.

--------------------------------------------------------------------------
Note: This plugin required apikey & uuid for the search api.

You can get both apiKey and uuid for free, here : http://www.waltsoft-inc.com/

----------------------------------------------------------------------------

## Table of contents
* [Search Features](#search-features)
* [Check the demo application](#check-the-demo-application)
* [Useful links](#useful-links)
* [Installation](#installation)
* [Example](#example)
* [Support and Feedback](#support-and-feedback)
* [About](#support-and-feedback)

## Search Features

* **Android & iOS** - Get all apps that match the query form google and apple store.

 Get App List Form Google Play Store  | Get App List Form Apple Store 
 -------------------------------| ------------------------------ 
 ![style1](screenshot_demo/android_search_demo.gif) | ![style10](screenshot_demo/apple_search_demo.gif)  
 
* **Search & Apps Data** - You can search app name, developer/seller name and you will get all the app Intelligence data you need for boths store according to the query.

 Search type  | Intelligence Data
 -------------|------------------ 
 ![style1](screenshot_demo/seller_search_demo.gif) | ![style10](screenshot_demo/appdetail_demo.gif)  
 

## Check the demo application

Explore the full capabilities of our Flutter widgets on your device by installing our sample browser applications from the below app stores, and view samples code in GitHub.


  <a href="https://play.google.com/store/apps/details?id=com.syncfusion.flutter.examples"><img src="https://cdn.syncfusion.com/content/images/FTControl/google-play-store.png"/></a>
  <a href="https://apps.apple.com/us/app/syncfusion-flutter-ui-widgets/id1475231341"><img src="https://cdn.syncfusion.com/content/images/FTControl/ios-store.png"/></a>
  
  <a href="https://flutter.syncfusion.com"><img src="https://cdn.syncfusion.com/content/images/FTControl/web-sample-browser.png"/></a> 
  <a href="https://github.com/syncfusion/flutter-examples"><img src="https://cdn.syncfusion.com/content/images/FTControl/github-samples.png"/></a>


## Useful links
Take a look at the following to learn more about Mobile App Stores Search Flutter widget:

* [User guide documentation](https://help.syncfusion.com/flutter/introduction/overview)
* [Official Website](https://www.syncfusion.com/flutter-widgets)
* [API reference](https://help.syncfusion.com/flutter/introduction/api-reference)

## Installation
 📂 **`pubspec.yaml`**:

**Note:** Install the latest version from [Pub](https://pub.dartlang.org/packages/flutter_background_geolocation/#-versions-tab-).

```yaml
dependencies:
  mobile_app_stores_search: '^1.0.0'
```
## Mobile App Stores Search Example


#### 1. Import the following package.

```dart
import 'package:mobile_app_stores_search/mobile_app_stores_search.dart';
```

#### 2. After importing the package, initialize the **mobileAppStoresSearch** widget.

```dart

  //-----> change it to your apikey and uuid,
  //You can get both [apiKey] and [uuid] for free, here : http://www.waltsoft-inc.com/ <-----//
  String apiKey = 'MzCPrAGBoYai9FOj6iGCP61Q6SekVGLV1P6Jfjwh';
  String uuid = 'vRmIU18pFljK3ecnG13v';
  late MobileAppStoresSearch mobileAppStoresSearch;
  String query = 'youtube';

  @override
  void initState() {
    //initializing mobile app store search api
    mobileAppStoresSearch = MobileAppStoresSearch(apiKey: apiKey, uuid: uuid);
    super.initState();
  }
```
#### 3. After initializing the package, call the **searchAppInStoreResponseJson** method and
* pass query and the app store type in the parameter.
* it will return a json list of app that match with the query.
* if no match found then it will return null.
```dart

var json = await mobileAppStoresSearch.searchAppInStoreResponseJson(
        searchQuery: query,
        searchInAppleStore: true);

```

Check an example app [Full Example](https://gist.github.com/christocracy/a0464846de8a9c27c7e9de5616082878)
## Support and feedback

* For any other queries, reach our [Website Name](https://www.syncfusion.com/support/directtrac/incidents/newincident).

