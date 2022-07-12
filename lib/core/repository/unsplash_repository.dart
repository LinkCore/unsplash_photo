import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../common/app_text.dart';
import '../model/unsplash_model.dart';

class UnsplashRepository {
  static final UnsplashRepository _unsplashRepository = UnsplashRepository._internal();

  factory UnsplashRepository() {
    return _unsplashRepository;
  }

  UnsplashRepository._internal();

  final List<UnsplashModel> _photoDataList = [];

  void clearCache(){
    _photoDataList.clear();
  }

  Future<List<UnsplashModel>> getDataList({required int page}) async {
    try {
      var response = await http.get(
          Uri.parse("https://api.unsplash.com/photos?page=$page&per_page=20"),
          headers: {'Authorization': 'Client-ID Zja0pCXNzSY0lxu5JQq-TJwcuKYlf9aiiGsIMDQH6PQ'
          });

      List<dynamic> data = jsonDecode(response.body);

      List<UnsplashModel> photoData = [];

      for (var element in data) {
        photoData.add(UnsplashModel.fromJson(element));
      }

      _photoDataList.addAll(photoData);

      return _photoDataList;

    } on Exception catch (e) {
      if (kDebugMode) {
        print('${AppText.cannotReachApi}: $e');
      }
      throw Exception(e);
    }
  }
}