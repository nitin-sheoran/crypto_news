import 'package:news_wave/all_imports.dart';
import 'package:news_wave/crypto/provider/crypto_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                NewsProvider(newsApiService: NewsApiService())),
        ChangeNotifierProvider(
            create: (context) =>
                CryptoProvider(marketApiService: MarketApiService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:saasaki_news_app/news/model/news_model.dart';
// import 'package:saasaki_news_app/news/provider/news_provider.dart';
// import 'package:saasaki_news_app/news/ui/favorite_news_screen.dart';
// import 'package:saasaki_news_app/news/ui/news_all_detail_screen.dart';
// import 'package:saasaki_news_app/news/utils/colors_const.dart';
// import 'package:saasaki_news_app/news/utils/string_const.dart';
//
// class NewsInformationScreen extends StatefulWidget {
//   const NewsInformationScreen({super.key});
//
//   @override
//   NewsScreen createState() => NewsScreen();
// }
//
// class NewsScreen extends State<NewsInformationScreen> {
//   late NewsProvider newsProvider;
//   late ScrollController _scrollController;
//   bool _isLoadingMore = false;
//
//   @override
//   void initState() {
//     super.initState();
//     newsProvider = Provider.of<NewsProvider>(context, listen: false);
//     newsProvider.fetchNews();
//     newsProvider.initSharedPreferences();
//     _scrollController = ScrollController()..addListener(_scrollListener);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _scrollListener() {
//     if (_scrollController.position.extentAfter < 10 && !_isLoadingMore) {
//       setState(() {
//         _isLoadingMore = true;
//       });
//       newsProvider.fetchMoreNews().then((_) {
//         setState(() {
//           _isLoadingMore = false;
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: ColorsConst.whiteColor,
//       ),
//       child: Scaffold(
//         backgroundColor: ColorsConst.whiteColor,
//         appBar: AppBar(
//           backgroundColor: ColorsConst.blueColor,
//           automaticallyImplyLeading: false,
//           title: Text(
//             '${newsProvider.selectedCategory[0].toUpperCase()}${newsProvider.selectedCategory.substring(1)} News',
//             style: const TextStyle(color: Colors.white),
//           ),
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(14),
//                 bottomLeft: Radius.circular(14),
//               )),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 4),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                               const BookMarkNewsScreen()));
//                     },
//                     icon: const Icon(
//                       Icons.save,
//                       color: ColorsConst.whiteColor,
//                     ),
//                   ),
//                   PopupMenuButton<String>(
//                     icon: const Icon(
//                       Icons.filter_list_rounded,
//                       color: ColorsConst.whiteColor,
//                     ),
//                     onSelected: (String category) {
//                       newsProvider.updateCategory(category);
//                     },
//                     color: ColorsConst.whiteColor,
//                     elevation: 1,
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         const PopupMenuItem(
//                           value: 'business',
//                           child: Text('Business News'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'entertainment',
//                           child: Text('Entertainment News'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'general',
//                           child: Text('General News'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'health',
//                           child: Text('Health News'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'science',
//                           child: Text('Science News'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'sports',
//                           child: Text('Sports News'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'technology',
//                           child: Text('Technology News'),
//                         ),
//                       ];
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         body: Consumer<NewsProvider>(
//           builder: (context, provider, child) {
//             if (provider.isLoading && provider.articles.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               List<Articles> articles = provider.articles;
//               articles.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
//               return ListView.builder(
//                 controller: _scrollController,
//                 itemCount: articles.length + (provider.isLoadingMore ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == articles.length) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   DateTime lastUpdatedDate =
//                   DateTime.parse(articles[index].publishedAt.toString());
//                   String formattedDate =
//                   DateFormat('dd MMM yyyy hh:mm a').format(lastUpdatedDate);
//                   bool isSaved = isCoinSaved(articles[index]);
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => NewsAllDetailScreen(
//                                   newsArticle: articles[index],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: ListTile(
//                             leading: SizedBox(
//                               height: 80,
//                               width: 100,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: articles[index].urlToImage != null
//                                     ? Image.network(
//                                   articles[index].urlToImage!,
//                                   fit: BoxFit.cover,
//                                 )
//                                     : Container(
//                                   color: ColorsConst.whiteColor,
//                                   child: Center(
//                                       child: Image.network(
//                                           StringConst.comingSoonImage)),
//                                 ),
//                               ),
//                             ),
//                             title: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   articles[index].title ?? '',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       articles[index].source?.name.toString() ??
//                                           '',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     const Spacer(),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         if (isSaved) {
//                                           removeCoin(articles[index]);
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(const SnackBar(
//                                               content: Text(StringConst
//                                                   .coinRemoved)));
//                                         } else {
//                                           saveCoin(articles[index]);
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(const SnackBar(
//                                               content: Text(StringConst
//                                                   .coinBookMarks)));
//                                         }
//                                         setState(() {
//                                           isSaved = !isSaved;
//                                         });
//                                       },
//                                       child: Icon(isSaved
//                                           ? Icons.bookmark
//                                           : Icons.bookmark_border_outlined),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   formattedDate,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const Divider(),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   bool isCoinSaved(Articles article) {
//     final bookmarkedNews = newsProvider.prefs?.getStringList('bookmarkedNews');
//     if (bookmarkedNews != null) {
//       final List<Articles> bookmarkedArticles = bookmarkedNews
//           .map((jsonString) => Articles.fromJson(json.decode(jsonString)))
//           .toList();
//       return bookmarkedArticles.any((savedArticle) => savedArticle.title == article.title);
//     }
//     return false;
//   }
//
//   void saveCoin(Articles article) {
//     final bookmarkedNews = newsProvider.prefs?.getStringList('bookmarkedNews');
//     if (bookmarkedNews != null) {
//       bookmarkedNews.add(json.encode(article.toJson()));
//       newsProvider.prefs?.setStringList('bookmarkedNews', bookmarkedNews);
//     } else {
//       newsProvider.prefs?.setStringList('bookmarkedNews', [json.encode(article.toJson())]);
//     }
//   }
//
//   void removeCoin(Articles article) {
//     final bookmarkedNews = newsProvider.prefs?.getStringList('bookmarkedNews');
//     if (bookmarkedNews != null) {
//       bookmarkedNews.removeWhere((jsonString) {
//         final savedArticle = Articles.fromJson(json.decode(jsonString));
//         return savedArticle.title == article.title;
//       });
//       newsProvider.prefs?.setStringList('bookmarkedNews', bookmarkedNews);
//     }
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:saasaki_news_app/news/model/news_model.dart';
// import 'package:saasaki_news_app/news/provider/news_provider.dart';
// import 'package:saasaki_news_app/news/ui/favorite_news_screen.dart';
// import 'package:saasaki_news_app/news/ui/news_all_detail_screen.dart';
// import 'package:saasaki_news_app/news/utils/colors_const.dart';
// import 'package:saasaki_news_app/news/utils/string_const.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class NewsInformationScreen extends StatefulWidget {
//   const NewsInformationScreen({super.key});
//
//   @override
//   _NewsInformationScreen createState() => _NewsInformationScreen();
// }
//
// class _NewsInformationScreen extends State<NewsInformationScreen> {
//   late NewsProvider newsProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     newsProvider = Provider.of<NewsProvider>(context, listen: false);
//     newsProvider.fetchNews();
//   }
//
//   void initSharedPreferences() async {
//     newsProvider.prefs = await SharedPreferences.getInstance();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: ColorsConst.whiteColor,
//       ),
//       child: Scaffold(
//         backgroundColor: ColorsConst.whiteColor,
//         appBar: AppBar(
//           backgroundColor: ColorsConst.blueColor,
//           automaticallyImplyLeading: false,
//           title: newsProvider.isSearching
//               ? Container(
//                   child: TextFormField(
//                     autofocus: true,
//                     cursorColor: ColorsConst.whiteColor,
//                     cursorHeight: 22,
//                     decoration: InputDecoration(
//                       isDense: true,
//                       hintText: 'Search...',
//                       hintStyle:
//                           const TextStyle(color: ColorsConst.white54Color),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: ColorsConst.whiteColor),
//                           borderRadius: BorderRadius.circular(8)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(color: ColorsConst.whiteColor),
//                           borderRadius: BorderRadius.circular(8)),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 6),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                     onChanged: (query) {
//                       setState(() {
//                         newsProvider.searchQuery = query;
//                       });
//                     },
//                   ),
//                 )
//               : Text(
//                   '${newsProvider.selectedCategory[0].toUpperCase()}${newsProvider.selectedCategory.substring(1)} News',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(14),
//             bottomLeft: Radius.circular(14),
//           )),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 2),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       newsProvider.isSearching ? Icons.close : Icons.search,
//                       color: ColorsConst.whiteColor,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         newsProvider.isSearching = !newsProvider.isSearching;
//                         newsProvider.searchQuery = '';
//                       });
//                     },
//                   ),
//                   const SizedBox(width: 4),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const BookMarkNewsScreen()));
//                     },
//                     child: const Icon(
//                       Icons.favorite_border,
//                       color: ColorsConst.whiteColor,
//                     ),
//                   ),
//                   PopupMenuButton<String>(
//                     icon: const Icon(
//                       Icons.filter_list_rounded,
//                       color: ColorsConst.whiteColor,
//                     ),
//                     onSelected: (String category) {
//                       newsProvider.updateCategory(category);
//                       setState(() {}); // Update the UI
//                     },
//                     color: ColorsConst.whiteColor,
//                     elevation: 1,
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         buildMenuItem('business', 'Business News'),
//                         buildMenuItem('entertainment', 'Entertainment News'),
//                         buildMenuItem('general', 'General News'),
//                         buildMenuItem('health', 'Health News'),
//                         buildMenuItem('science', 'Science News'),
//                         buildMenuItem('sports', 'Sports News'),
//                         buildMenuItem('technology', 'Technology News'),
//                       ];
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         body: Consumer<NewsProvider>(
//           builder: (context, provider, child) {
//             if (provider.isLoading && provider.articles.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               List<Articles> articles = provider.articles;
//               if (newsProvider.searchQuery.isNotEmpty) {
//                 articles = articles.where((article) {
//                   return article.title!
//                       .toLowerCase()
//                       .contains(newsProvider.searchQuery.toLowerCase());
//                 }).toList();
//               }
//               articles.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
//               return ListView.builder(
//                 itemCount: articles.length + (provider.isLoadingMore ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == articles.length) {
//                     return const Padding(
//                       padding: EdgeInsets.only(bottom: 20),
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   }
//                   DateTime lastUpdatedDate =
//                       DateTime.parse(articles[index].publishedAt.toString());
//                   String formattedDate =
//                       DateFormat('dd MMM yyyy hh:mm a').format(lastUpdatedDate);
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 14, right: 14),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => NewsAllDetailScreen(
//                                   newsArticle: articles[index],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             leading: SizedBox(
//                               height: 80,
//                               width: 100,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: articles[index].urlToImage != null
//                                     ? Image.network(
//                                         articles[index].urlToImage!,
//                                         fit: BoxFit.cover,
//                                       )
//                                     : Container(
//                                         color: ColorsConst.whiteColor,
//                                         child: Center(
//                                           child: Image.network(
//                                             StringConst.comingSoonImage,
//                                           ),
//                                         ),
//                                       ),
//                               ),
//                             ),
//                             title: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   articles[index].title ?? '',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Text(
//                                   articles[index].source?.name.toString() ?? '',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       formattedDate,
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     GestureDetector(
//                                       onTap: () {
//                                       },
//                                       child: Icon( Icons.favorite
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const Divider(),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   PopupMenuItem<String> buildMenuItem(String value, String text) {
//     return PopupMenuItem<String>(
//       value: value,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: newsProvider.selectedCategory == value
//               ? ColorsConst.blueColor
//               : Colors.black,
//         ),
//       ),
//     );
//   }
//
// }

/*class NewsInformationScreen extends StatefulWidget {
  const NewsInformationScreen({super.key});

  @override
  _NewsInformationScreen createState() => _NewsInformationScreen();
}

class _NewsInformationScreen extends State<NewsInformationScreen> {
  late NewsProvider newsProvider;

  @override
  void initState() {
    super.initState();
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchNews();
    newsProvider.initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorsConst.whiteColor,
      ),
      child: Scaffold(
        backgroundColor: ColorsConst.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorsConst.blueColor,
          automaticallyImplyLeading: false,
          title: newsProvider.isSearching
              ? Container(
            child: TextFormField(
              autofocus: true,
              cursorColor: ColorsConst.whiteColor,
              cursorHeight: 22,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search...',
                hintStyle:
                const TextStyle(color: ColorsConst.white54Color),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: ColorsConst.whiteColor),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: ColorsConst.whiteColor),
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (query) {
                setState(() {
                  newsProvider.searchQuery = query;
                });
              },
            ),
          )
              : Text(
            '${newsProvider.selectedCategory[0].toUpperCase()}${newsProvider.selectedCategory.substring(1)} News',
            style: const TextStyle(color: Colors.white),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      newsProvider.isSearching ? Icons.close : Icons.search,
                      color: ColorsConst.whiteColor,
                    ),
                    onPressed: () {
                      setState(() {
                        newsProvider.isSearching = !newsProvider.isSearching;
                        newsProvider.searchQuery = '';
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const BookMarkNewsScreen()));
                    },
                    child: const Icon(
                      Icons.favorite_border,
                      color: ColorsConst.whiteColor,
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.filter_list_rounded,
                      color: ColorsConst.whiteColor,
                    ),
                    onSelected: (String category) {
                      newsProvider.updateCategory(category);
                      setState(() {}); // Update the UI
                    },
                    color: ColorsConst.whiteColor,
                    elevation: 1,
                    itemBuilder: (BuildContext context) {
                      return [
                        buildMenuItem('business', 'Business News'),
                        buildMenuItem('entertainment', 'Entertainment News'),
                        buildMenuItem('general', 'General News'),
                        buildMenuItem('health', 'Health News'),
                        buildMenuItem('science', 'Science News'),
                        buildMenuItem('sports', 'Sports News'),
                        buildMenuItem('technology', 'Technology News'),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Consumer<NewsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.articles.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Articles> articles = provider.articles;
              if (newsProvider.searchQuery.isNotEmpty) {
                articles = articles.where((article) {
                  return article.title!
                      .toLowerCase()
                      .contains(newsProvider.searchQuery.toLowerCase());
                }).toList();
              }
              articles.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
              return ListView.builder(
                itemCount: articles.length + (provider.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == articles.length) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  DateTime lastUpdatedDate =
                  DateTime.parse(articles[index].publishedAt.toString());
                  String formattedDate =
                  DateFormat('dd MMM yyyy hh:mm a').format(lastUpdatedDate);
                  return Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsAllDetailScreen(
                                  newsArticle: articles[index],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SizedBox(
                              height: 80,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: articles[index].urlToImage != null
                                    ? Image.network(
                                  articles[index].urlToImage!,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  color: ColorsConst.whiteColor,
                                  child: Center(
                                    child: Image.network(
                                      StringConst.comingSoonImage,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  articles[index].title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  articles[index].source?.name.toString() ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        provider.toggleFavorite(articles[index].title ?? '');
                                      },
                                      child: Icon(
                                        provider.isFavorite(articles[index].title ?? '')
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: provider.isFavorite(articles[index].title ?? '')
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> buildMenuItem(String value, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        text,
        style: TextStyle(
          color: newsProvider.selectedCategory == value
              ? ColorsConst.blueColor
              : Colors.black,
        ),
      ),
    );
  }
}*/

// class NewsProvider with ChangeNotifier {
//   final NewsApiService newsApiService;
//
//   NewsProvider({
//     required this.newsApiService,
//   });
//
//   List<Articles> _articles = [];
//   String _selectedCategory = 'general';
//   bool _isLoading = false;
//   SharedPreferences? prefs;
//   int _currentPage = 1;
//   bool isLoadingMore = false;
//   bool isSearching = false;
//   String searchQuery = '';
//   List<String> _favoriteArticles = [];
//
//   List<Articles> get articles => _articles;
//   String get selectedCategory => _selectedCategory;
//   bool get isLoading => _isLoading;
//   List<String> get favoriteArticles => _favoriteArticles;
//
//   Future<void> fetchNews({int page = 1}) async {
//     if (page == 1) {
//       _isLoading = true;
//       notifyListeners();
//     } else {
//       isLoadingMore = true;
//       notifyListeners();
//     }
//     List<Articles> fetchedArticles = await newsApiService.fetchNews(_selectedCategory, page);
//     if (page == 1) {
//       _articles = fetchedArticles;
//     } else {
//       _articles.addAll(fetchedArticles);
//     }
//
//     _isLoading = false;
//     isLoadingMore = false;
//     _currentPage = page;
//     notifyListeners();
//   }
//
//   void initSharedPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//     _favoriteArticles = prefs?.getStringList('favorites') ?? [];
//     notifyListeners();
//   }
//
//   Future<void> fetchMoreNews() async {
//     await fetchNews(page: _currentPage + 1);
//   }
//
//   void updateCategory(String category) {
//     _selectedCategory = category;
//     _currentPage = 1;
//     fetchNews();
//   }
//
//   void toggleFavorite(String title) {
//     if (_favoriteArticles.contains(title)) {
//       _favoriteArticles.remove(title);
//     } else {
//       _favoriteArticles.add(title);
//     }
//     prefs?.setStringList('favorites', _favoriteArticles);
//     notifyListeners();
//   }
//
//   bool isFavorite(String title) {
//     return _favoriteArticles.contains(title);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:saasaki_news_app/news/model/news_model.dart';
// import 'package:saasaki_news_app/news/service/news_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class NewsProvider with ChangeNotifier {
//   final NewsApiService newsApiService;
//
//   NewsProvider({
//     required this.newsApiService,
//   });
//
//   List<Articles> _articles = [];
//   String _selectedCategory = 'general';
//   bool _isLoading = false;
//   SharedPreferences? prefs;
//   int _currentPage = 1;
//   bool isLoadingMore = false;
//   late ScrollController scrollController;
//   bool isSearching = false;
//   String searchQuery = '';
//
//   List<Articles> get articles => _articles;
//   String get selectedCategory => _selectedCategory;
//   bool get isLoading => _isLoading;
//
//   Future<void> fetchNews({int page = 1}) async {
//     if (page == 1) {
//       _isLoading = true;
//       notifyListeners();
//     } else {
//       isLoadingMore = true;
//       notifyListeners();
//     }
//     List<Articles> fetchedArticles = await newsApiService.fetchNews(_selectedCategory, page);
//     if (page == 1) {
//       _articles = fetchedArticles;
//     } else {
//       _articles.addAll(fetchedArticles);
//     }
//
//     _isLoading = false;
//     isLoadingMore = false;
//     _currentPage = page;
//     notifyListeners();
//   }
//
//   void initSharedPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//   }
//
//   Future<void> fetchMoreNews() async {
//     await fetchNews(page: _currentPage + 1);
//   }
//
//   void updateCategory(String category) {
//     _selectedCategory = category;
//     _currentPage = 1;
//     fetchNews();
//   }
// }
