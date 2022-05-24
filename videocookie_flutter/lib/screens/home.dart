import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Item {
  final int itemId;
  final String filePath;
  final int price;
  final int orderCnt;
  final String thumbnail;
  final String mainCategory;
  final String title;
  final String zipFile;
  final String sampleFile;
  final String isAccept;
  final String regDate;
  final String author;
  final int authorId;
  final String productType;
  final String eventEndDate;
  final String eventStartDate;
  final String discountRate;
  final String categories;
  final String itemType;
  final String sizeX;
  final String sizeY;

  const Item(
      {required this.itemId, required this.filePath, required this.price, required this.orderCnt, required this.thumbnail, required this.mainCategory, required this.title, required this.zipFile, required this.sampleFile, required this.isAccept, required this.regDate, required this.author, required this.authorId, required this.productType, required this.eventEndDate, required this.eventStartDate, required this.discountRate, required this.categories, required this.itemType, required this.sizeX, required this.sizeY});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        itemId : json['itemId'],
        filePath : json['filePath'],
        price : json['price'],
        orderCnt : json['orderCnt'],
        thumbnail : json['thumbnail'],
        mainCategory : json['mainCategory'],
        title : json['title'],
        zipFile : json['zipFile'],
        sampleFile : json['sampleFile'],
        isAccept : json['isAccept'],
        regDate : json['regDate'],
        author : json['author'],
        authorId : json['authorId'],
        productType : json['productType'],
        eventEndDate : json['eventEndDate'],
        eventStartDate : json['eventStartDate'],
        discountRate : json['discountRate'],
        categories : json['categories'],
        itemType : json['itemType'],
        sizeX : json['sizeX'],
        sizeY : json['sizeY'],
    );
  }
}

class SearchType {
  final String mainCategory;
  final List<int> categories;
  final List<int> applicationsSupported;
  final List<int> fileTypes;
  final List<int> frame;
  final List<int> genre;
  final List<int> language;
  final List<int> platform;
  final List<int> situation;
  final int currentPage;
  final String selected;
  final String search;

  const SearchType({required this.mainCategory, required this.categories, required this.applicationsSupported, required this.fileTypes, required this.frame, required this.genre, required this.language, required this.platform, required this.situation, required this.currentPage, required this.selected, required this.search});

  Map getSearchType () {
    return {
      'mainCategory': this.mainCategory,
      'categories' : this.categories,
      'applicationsSupported' : this.applicationsSupported,
      'fileTypes' : this.fileTypes,
      'frame' : this.frame,
      'genre' : this.genre,
      'language' : this.language,
      'platform' : this.platform,
      'situation' : this.situation,
      'currentPage': this.currentPage,
      'selected' : this.selected,
      'search' : this.search == "" ? null : this.search,
    };
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SearchType searchType = new SearchType(mainCategory: "subtitleTemplate", categories: [], applicationsSupported: [], fileTypes: [], frame: [], genre: [], language: [], platform: [], currentPage: 0, search: "", situation: [], selected: '전체');
    String url = 'http://10.0.2.2:8080/api/item/flutter/getItemList';

    post(url,searchType.getSearchType()).then((String res) {
      final data = jsonDecode(res);
      print(data['data']['content'][0]);

      data['data']['content'].forEach((item) {
        print(Item.fromJson(item));
      });
      // List<Map<String, dynamic>> list = data.data.content;
    });
    super.initState();
  }

  Future<String> post(String url, Map jsonMap) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Future<String> get(String url) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    final data = jsonDecode(reply);
    print(data);
    return reply;
  }

  Future<void> getItemList () async {

    var formMap = {
      'mainCategory': "subtitleTemplate",
      'categories' : '',
      'applicationsSupported' : [1,2],
      // 'fileTypes' : [],
      // 'frame' : [],
      // 'genre' : [],
      // 'language' : [],
      // 'platform' : [],
      // 'situation' : [],
      'currentPage': '0',
      'selected' : "전체",
      'search' : '',
    };



    String url = 'http://10.0.2.2:8080/api/user/flutter/getItemList';
    http.Response response = await http.post(Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      },
      // body: jsonEncode({'mainCategory': "subtitleTemplate", 'selected' : "전체"}),
      body:  formMap
    );
    final decodeData = utf8.decode(response.bodyBytes);
    final data = jsonDecode(decodeData);
    // print(data['code']);
    // print(data['message']);
    print(data['data']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // 수평적으로 대칭(symmetric)의 마진을 추가 -> 화면 위, 아래에 20픽세의 마진 삽입
          // margin: EdgeInsets.symmetric(vertical: 10.0),
          // 컨테이너의 높이를 200으로 설정
          height: 80.0,
          child: ListView(
            // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
            scrollDirection: Axis.horizontal,
            // 컨테이너들을 ListView의 자식들로 추가
            children: <Widget>[
              Container(
                width: 160.0,
                color: Colors.red,
              ),
              Container(
                width: 160.0,
                color: Colors.blue,
              ),
              Container(
                width: 160.0,
                color: Colors.green,
              ),
              Container(
                width: 160.0,
                color: Colors.yellow,
              ),
              Container(
                width: 160.0,
                color: Colors.orange,
              )
            ],
          ),
        ),
        Expanded(child: ItemList())
      ],
    );
  }
}


Widget ItemList () {
  return ListView.builder(itemCount: 3, itemBuilder: (c, i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network('https://codingapple1.github.io/app/car0.png'),
        Text('좋아요 100'),
        Text('글쓴이'),
        Text('내용'),
      ],
    );
  });
}
