import 'package:flutter/material.dart';
import 'package:mobile_app_stores_search/mobile_app_stores_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Stores Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //-----> change this to your apikey and uuid,
  //You can get both [apiKey] and [uuid] for free, here : http://www.waltsoft-inc.com/ <-----//
  String apiKey = 'MzCPrAGBoYai9FOj6iGCP61Q6SekVGLV1P6Jfjwh';
  String uuid = 'vRmIU18pFljK3ecnG13v';
  late MobileAppStoresSearch mobileAppStoresSearch;
  //other fields
  String query = 'youtube';
  // true if you want to search on apple store and false for google store
  bool searchInAppleStore = false;
  late List<AppDetail> searchedAppList = [];
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: query);
    //initializing mobile app store search api
    mobileAppStoresSearch = MobileAppStoresSearch(apiKey: apiKey, uuid: uuid);
    super.initState();
  }

  updateSearchedAppList() async {
    var json = await mobileAppStoresSearch.searchAppInStoreResponseJson(
        searchQuery: _textEditingController.text,
        searchInAppleStore: !searchInAppleStore);
    searchedAppList = [];

    for (int i = 0; i < json.length; i++) {
      var map = json.elementAt(i);
      searchedAppList.add(AppDetail.fromMap(map, searchInAppleStore));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile App Stores Search'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                          hintText: 'Search App Name or Seller/Developer Name',
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        updateSearchedAppList();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              Row(
                children: [
                  Text(
                      'Searching on (${searchInAppleStore ? 'Ios' : 'Android'}) Store',
                      style: const TextStyle(fontSize: 20)),
                  const Expanded(
                      child: SizedBox(
                    width: 5,
                  )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          searchInAppleStore = false;
                        });
                      },
                      icon: Icon(
                        Icons.android,
                        size: 35,
                        color: !searchInAppleStore ? Colors.blue : Colors.grey,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          searchInAppleStore = true;
                        });
                      },
                      icon: ImageIcon(
                        const NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/notifications-tracker.appspot.com/o/ios_png.png?alt=media&token=7b7cef7b-16b4-48aa-be44-e6bc21d4651f',
                        ),
                        color: searchInAppleStore ? Colors.blue : Colors.grey,
                      )),
                ],
              ),
              const Text('Search Result', style: TextStyle(fontSize: 20)),
              Expanded(
                child: ListView.builder(
                    itemCount: searchedAppList.length,
                    itemBuilder: (context, index) {
                      AppDetail appDetail = searchedAppList.elementAt(index);
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: Image.network(appDetail.iconUrl),
                          title: Text(appDetail.appName),
                          subtitle: Text(appDetail.sellerName,
                              style: const TextStyle(color: Colors.blue)),
                          trailing: appDetail.platformIsAndroid
                              ? const Icon(Icons.android, size: 28)
                              : const ImageIcon(
                                  NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/notifications-tracker.appspot.com/o/ios_png.png?alt=media&token=7b7cef7b-16b4-48aa-be44-e6bc21d4651f',
                                  ),
                                  color: Colors.grey,
                                ),
                          onTap: () {
                            appDetailsDialog(appDetail);
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }

  appDetailsDialog(AppDetail appDetail) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
            child: Container(
                color: Colors.white,
                height: 420,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text('App Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Icon', style: TextStyle(fontSize: 16)),
                            Image.network(appDetail.iconUrl,
                                width: 50, height: 50),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Name', style: TextStyle(fontSize: 16)),
                            Text(appDetail.appName,
                                style: const TextStyle(fontSize: 16)),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Seller Name',
                                style: TextStyle(fontSize: 16)),
                            Text(appDetail.sellerName,
                                style: const TextStyle(fontSize: 16)),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('App Is Free?',
                                style: TextStyle(fontSize: 16)),
                            Text(appDetail.free.toString(),
                                style: const TextStyle(fontSize: 16)),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('App Id',
                                style: TextStyle(fontSize: 16)),
                            Text(appDetail.appId,
                                style: const TextStyle(fontSize: 16)),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('App Price',
                                style: TextStyle(fontSize: 16)),
                            Text(appDetail.appPrice,
                                style: const TextStyle(fontSize: 16)),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('App Url Link',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 20),
                            Flexible(
                              child: Text(appDetail.appUrlLink,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16)),
                            ),
                          ]),
                      const Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('App Platform Type',
                                style: TextStyle(fontSize: 16)),
                            Text(
                                appDetail.platformIsAndroid ? 'Android' : 'Ios',
                                style: const TextStyle(fontSize: 16)),
                          ]),
                      const SizedBox(height: 10),
                    ],
                  ),
                ))));
  }
}

class AppDetail {
  String appName;
  String sellerName;
  String iconUrl;
  bool free;
  String appId;
  String appPrice;
  String appUrlLink;
  bool platformIsAndroid;

  AppDetail({
    required this.appName,
    required this.appId,
    required this.sellerName,
    required this.appUrlLink,
    required this.iconUrl,
    required this.appPrice,
    required this.free,
    required this.platformIsAndroid,
  });

  factory AppDetail.fromMap(map, bool searchInAppleStore) {
    return AppDetail(
      appUrlLink: map['url'],
      appName: map['title'],
      appId: map['app_id'],
      sellerName: map['developer'],
      iconUrl: map['icon'],
      appPrice: map['price'] ?? '',
      free: map['free'] ?? false,
      platformIsAndroid: !searchInAppleStore,
    );
  }
}
