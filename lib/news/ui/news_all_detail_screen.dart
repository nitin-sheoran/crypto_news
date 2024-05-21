import 'package:intl/intl.dart';
import 'package:news_wave/all_imports.dart';

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
    DateTime lastUpdatedDate =
        DateTime.parse(widget.newsArticle.publishedAt.toString());
    String formattedDate =
        DateFormat('dd MMM yyyy hh:mm a').format(lastUpdatedDate);
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
      appBar: AppBar(
        titleSpacing: -8,
        backgroundColor:
            darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        title: const Text(
          'News',
          style: TextStyle(color: ColorsConst.whiteColor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsConst.whiteColor,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Share.share(
                  '${widget.newsArticle.title}\n${widget.newsArticle.description}\n${widget.newsArticle.content}\n${widget.newsArticle.urlToImage}',
                );
              },
              icon: const Icon(
                Icons.share,
                color: ColorsConst.white54Color,
              ),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
        child: Card(
          color: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
          surfaceTintColor:
              darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
          elevation: 10,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 20),
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
                        child: widget.newsArticle.urlToImage != null
                            ? Image.network(
                                widget.newsArticle.urlToImage ?? '',
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 200,
                                color: ColorsConst.whiteColor,
                                child: Center(
                                    child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9b7ve9oIilsA8oz5bbsrKZvAe2oT7ESuFKKUO3eHWRL0LEnOQnzz4lRHYAg&s')),
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
                                    fontSize: 48,
                                    color: ColorsConst.blueColor)),
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
                      height: 10,
                    ),
                    Text(formattedDate,
                        style: TextStyle(
                          fontSize: 16,
                          color: darkMode
                              ? ColorsConst.whiteColor
                              : ColorsConst.blackColor,
                        )),
                    const SizedBox(
                      height: 10,
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
