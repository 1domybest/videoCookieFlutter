import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

import '../model/SearchType.dart';
import '../viewModel/item_list_view_model.dart';

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}


class _ListState extends State<List> {
  var itemList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SearchType searchType = new SearchType(mainCategory: "subtitleTemplate", categories: [], applicationsSupported: [], fileTypes: [], frame: [], genre: [], language: [], platform: [], currentPage: 0, search: "", situation: [], selected: '전체');
    String url = 'http://10.0.2.2:8080/api/item/flutter/getItemList';
    Provider.of<ItemListViewModel>(context) // listen: true (UI변경 + data 변경) || listen:: false (only data 변경시)
        .getItemList(url, searchType.getSearchType()); // api로 데이터 가져오기 ex) created
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemViewModelList = Provider.of<ItemListViewModel>(context).itemList;
    return Column(
      children: [
        Container(
          // 수평적으로 대칭(symmetric)의 마진을 추가 -> 화면 위, 아래에 20픽세의 마진 삽입
          // margin: EdgeInsets.symmetric(vertical: 10.0),
          // 컨테이너의 높이를 200으로 설정
          height: 50.0,
          child: ListView(
            // 스크롤 방향 설정. 수평적으로 스크롤되도록 설정
            scrollDirection: Axis.horizontal,
            // 컨테이너들을 ListView의 자식들로 추가
            children: <Widget>[
              Container(
                width: 140.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('비디오 템플릿')
                  ],
                ),
              ),
              Container(
                width: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('자막 템플릿')
                  ],
                ),
              ),
              Container(
                width: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('모션그래픽 스티커')
                  ],
                ),
              ),
              Container(
                width: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('스톡비디오')
                  ],
                ),
              ),
              Container(
                width: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('비디오 효과음')
                  ],
                ),
              ),
              Container(
                width: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('이미지')
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(child: ItemList(itemViewModelList))
      ],
    );
  }
}


Widget ItemList (list) {
  return ListView.builder(itemCount: list.length, itemBuilder: (c, i) {
    return Column(
      children: [
        Image.file(list[i].img),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(list[i].title, style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w900),),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(list[i].author, style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.w900)),
                    Icon(Icons.shopping_bag, size: 35,)
                  ],
                ),
              ),
              Container(
                height: 3,
                color: Colors.grey[300],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.centerRight,
                child: Text(list[i].price.toString() + '원', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Colors.black),),
              )
            ],
          ),
        )
      ],
    );
  });
}
