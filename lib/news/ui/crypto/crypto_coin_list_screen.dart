import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_wave/news/model/crypto_coin_info.dart';
import 'package:news_wave/news/service/market_api_service.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/news/ui/crypto/crypto_market_detail_screen.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CryptoCoinListScreen extends StatefulWidget {
  const CryptoCoinListScreen({Key? key}) : super(key: key);

  @override
  State<CryptoCoinListScreen> createState() => _CryptoCoinListScreenState();
}

class _CryptoCoinListScreenState extends State<CryptoCoinListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(microseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(microseconds: 1000));
    _refreshController.loadComplete();
  }

  late MarketApiService marketApiService;
  List<CryptoCoinInfo> cryptoList = [];

  bool loading = false;

  getData() async {
    setState(() {
      loading = true;
    });
    cryptoList = await MarketApiService.getApiData();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    SmartRefresher(
      controller: _refreshController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: darkMode
            ? ColorsConst.blackColor
            : ColorsConst.whiteColor,
        title:  Text(
          'Crypto',
          style: TextStyle(color: darkMode
              ? ColorsConst.whiteColor
              : ColorsConst.blackColor),
        ),
        backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text('');
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text('Load Failed!Click retry!');
            } else if (mode == LoadStatus.canLoading) {
              body = const Text('release to load more');
            } else {
              body = const Text('No more Data');
            }
            return Container(
              height: 55.0,
              child: Center(
                child: body,
              ),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: cryptoList.length,
                itemBuilder: (context, index) {
                  CryptoCoinInfo cryptoCoinInfo = cryptoList[index];

                  return Slidable(
                    key: const ValueKey(0),
                    startActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        /*SlidableAction(
                          onPressed: (context) => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BuyScreen(cryptoCoinInfo: cryptoCoinInfo);
                          })),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          icon: Icons.ac_unit_outlined,
                          label: 'Buy',
                        ),*/
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CryptoMaretDetailScreen(
                              cryptoCoinInfo: cryptoCoinInfo);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.network(
                                cryptoCoinInfo.image.toString(),
                                height: 24,
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cryptoCoinInfo.name.toString(),
                                    style:  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor
                                    ),
                                  ),
                                  Text(
                                    cryptoCoinInfo.currentPrice.toString(),
                                    style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Container(
                                    height: 18,
                                    width: 18,
                                    decoration:  BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.black54Color,
                                    ),
                                    child: Text(
                                      cryptoCoinInfo.marketCapRank.toString(),
                                      textAlign: TextAlign.center,
                                      style:
                                           TextStyle(color:darkMode
                                              ? ColorsConst.blackColor
                                              : ColorsConst.whiteColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    cryptoCoinInfo.symbol.toString(),style: TextStyle(color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
