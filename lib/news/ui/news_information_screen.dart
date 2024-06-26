import 'package:news_wave/all_imports.dart';
import 'package:intl/intl.dart';

class NewsInformationScreen extends StatefulWidget {
  const NewsInformationScreen({super.key});

  @override
  NewsScreen createState() => NewsScreen();
}

class NewsScreen extends State<NewsInformationScreen> {
  late NewsProvider newsProvider;

  @override
  void initState() {
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorsConst.whiteColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
          title: const Text(
            StringConst.cryptoNews,
            style: TextStyle(
                color: ColorsConst.whiteColor),
          ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(14),
            bottomLeft: Radius.circular(14),
          )),
        ),
        body: FutureBuilder<List<Articles>>(
          future: newsProvider.newsApiService.fetchCollegeNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Articles>? articles = snapshot.data;
              articles?.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 160.0,
                          viewportFraction: 0.7,
                          enlargeCenterPage: true,
                          autoPlay: true,
                        ),
                        items: articles?.map((article) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: article.urlToImage != null
                                        ? Image.network(
                                            article.urlToImage ?? '',
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: ColorsConst.whiteColor,
                                            child: Center(
                                                child: Image.network(
                                                    StringConst.comingSoonImage)),
                                          ),
                                  );
                                },
                              );
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          StringConst.latestNews,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkMode
                                ? ColorsConst.whiteColor
                                : ColorsConst.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: articles?.length,
                      itemBuilder: (context, index) {
                        DateTime lastUpdatedDate = DateTime.parse(articles![index].publishedAt.toString());
                        String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(lastUpdatedDate);
                        return Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
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
                                              child:  Center(
                                                  child: Image.network(
                                                      StringConst.comingSoonImage)),
                                            ),
                                    ),
                                  ),
                                  title: Column(
                                    children: [
                                      Text(
                                        articles[index].title ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: darkMode
                                              ? ColorsConst.whiteColor
                                              : ColorsConst.blackColor,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(formattedDate,style: TextStyle(fontSize: 12, color: darkMode
                                              ? ColorsConst.whiteColor
                                              : ColorsConst.blackColor,),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(endIndent: 20,indent: 20,),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
        backgroundColor:
            darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
      ),
    );
  }

  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedTime;
  }
}
