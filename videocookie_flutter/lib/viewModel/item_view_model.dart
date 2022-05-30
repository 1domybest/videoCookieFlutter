import 'dart:io';

import '../model/Item.dart';



class ItemViewModel {
  Item _item;

  ItemViewModel({required Item item}) : _item = item;

  int get itemId => _item.itemId;

  String get filePath => _item.filePath;

  int get price => _item.price;

  int get orderCnt => _item.orderCnt;

  String get thumbnail => _item.thumbnail;

  String get mainCategory => _item.mainCategory;

  String get title => _item.title;

  String get zipFile => _item.zipFile;

  String get sampleFile => _item.sampleFile;

  String get isAccept => _item.isAccept;

  String get regDate => _item.regDate;

  String get author => _item.author;

  int get authorId => _item.authorId;

  String get productType => _item.productType;

  String get eventEndDate => _item.eventEndDate;

  String get eventStartDate => _item.eventStartDate;

  int get discountRate => _item.discountRate;

  int get categories => _item.categories;

  String get itemType => _item.itemType;

  int get sizeY => _item.sizeY;

  int get sizeX => _item.sizeX;

  File get img => _item.img;

}
