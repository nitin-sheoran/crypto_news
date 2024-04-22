import 'package:flutter/material.dart';
import 'package:news_wave/news/service/news_service.dart';

class NewsProvider with ChangeNotifier {
  NewsApiService newsApiService;

  NewsProvider({
    required this.newsApiService,
  });
  bool notification = true;
  bool private = false;
}

