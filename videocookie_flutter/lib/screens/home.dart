import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    getItemList();
    super.initState();
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
