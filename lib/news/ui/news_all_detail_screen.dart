import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/news/model/news_model.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:provider/provider.dart';

class NewsAllDetailScreen extends StatefulWidget {
  const NewsAllDetailScreen({required this.newsArticle, super.key});

  final Articles newsArticle;

  @override
  State<NewsAllDetailScreen> createState() => _NewsAllDetailScreenState();
}

class _NewsAllDetailScreenState extends State<NewsAllDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
        child: Card(
          color: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
          surfaceTintColor:
              darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
          elevation: 400,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 14, right: 14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.network(
                          widget.newsArticle.urlToImage ?? '',
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const Column(
                          children: [
                            Text('|',
                                style: TextStyle(
                                    fontSize: 48, color: ColorsConst.orangeColor)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.newsArticle.title ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: darkMode
                                        ? ColorsConst.whiteColor
                                        : ColorsConst.blackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.newsArticle.description!,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.whiteColor
                            : ColorsConst.blackColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.newsArticle.content!,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.whiteColor
                            : ColorsConst.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedTime;
  }
}
