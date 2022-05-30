import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  final int discountRate;
  final int categories;
  final String itemType;
  final int sizeX;
  final int sizeY;
  final File img;

  Item({required this.img,
    required this.itemId, required this.filePath, required this.price, required this.orderCnt, required this.thumbnail, required this.mainCategory, required this.title, required this.zipFile, required this.sampleFile, required this.isAccept, required this.regDate, required this.author, required this.authorId, required this.productType, required this.eventEndDate, required this.eventStartDate, required this.discountRate, required this.categories, required this.itemType, required this.sizeX, required this.sizeY
});


  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId : json['itemId']?? 0,
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
      eventEndDate : json['eventEndDate'] ?? "",
      eventStartDate : json['eventStartDate']?? "",
      discountRate : json['discountRate'],
      categories : json['categories'],
      itemType : json['itemType'],
      sizeX : json['sizeX']?? 0,
      sizeY : json['sizeY']?? 0,
      img: json["img"] ?? new File(""),
    );
  }
}

