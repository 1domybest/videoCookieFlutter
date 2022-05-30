import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:videocookie_flutter/service/item_service.dart';

import '../model/Item.dart';
import 'item_view_model.dart';



enum LoadingStatus { completed, searching, empty }

class ItemListViewModel extends ChangeNotifier {
  //초기에 로딩 데이터 없음
  LoadingStatus loadingStatus = LoadingStatus.empty; // 상태 비어있음으로 초기화

  List<ItemViewModel> itemList = <ItemViewModel>[]; // NewsArticleViewModel 은 jpa에서 domain이 아닌 request 혹은 response 를 위한 dto 같은 개념이다

  //기사 가져오기
  void getItemList(String url, Map searchType) async {
    //기사 가져오고 현재 상태 로딩중으로 변경
    List<Item> items = await ItemService().fetchItemList(url, searchType); // dio RestApi 로 데이터 불러오기
    loadingStatus = LoadingStatus.searching; // 상태를 searching 으로 바꿔줌
    notifyListeners(); // View단에서  topHeadLines 를 initState를 통해 호출하면 첫째로 api를 불러오고 상태를 현재 검색증으로 바꾼후 이 상태를 Provider에 알려준다

    this.itemList = items // 받아온 데이터를 map으로 바꾼후
        .map((item) => ItemViewModel(item: item)).cast<ItemViewModel>() // 만들어둔 NewsArticleViewModel의 생성자를 통해 객체로 변환시켜준다 여기서 item은 받아온 newsArticles 이다.
        .toList();  // toList를통해 리스트로 만들어준다


    //가져온 데이터가 비어있으면 빈 상태 아니면 성공 상태
    this.loadingStatus =
    this.itemList.isEmpty ? LoadingStatus.empty : LoadingStatus.completed; // 받아온 데이터가 비어있으면 loadingStatus를 비어있음 혹은 완료로 바꾸어준다
    notifyListeners();

  }
}

Future<String?> getThumbnail (String sampleFile) async {
  final thumbnail = await VideoThumbnail.thumbnailFile(
    video: sampleFile,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 0,
    quality: 100,
  );
  return thumbnail;
}
