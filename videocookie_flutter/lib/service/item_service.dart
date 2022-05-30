import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../model/Item.dart';

class ItemService {
  var dio = Dio();

  Future<List<Item>> fetchItemList(String url, Map searchType) async {
    print(url);
    final response = await dio.request(
      url,
      data: searchType,
      options: Options(method:'POST'),
    );
    if (response.statusCode == 200) {
      final result = response.data;
      List<dynamic> list = result['data']['content'];
      for (int i = 0; i < list.length; i ++) {
       await getThumbnail(Uri.decodeComponent(list[i]['sampleFile'])).then((res) async {
          final file =  File(res!);
          list[i]['img'] = file;
        });
      }
      return list.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("failed to get top news");
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
}
