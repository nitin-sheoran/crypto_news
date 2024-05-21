import 'package:news_wave/all_imports.dart';

class NewsProvider with ChangeNotifier {
  NewsApiService newsApiService;

  NewsProvider({
    required this.newsApiService,
  });
  bool notification = true;
  bool private = false;
}

