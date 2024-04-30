import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/crypto/model/crypto_coin_info_model.dart';
import 'package:news_wave/crypto/service/market_api_service.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/crypto/ui/crypto_market_detail_screen.dart';
import 'package:news_wave/crypto/ui/save_coin_screen.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoCoinListScreen extends StatefulWidget {
  const CryptoCoinListScreen({Key? key}) : super(key: key);

  @override
  State<CryptoCoinListScreen> createState() => _CryptoCoinListScreenState();
}

class _CryptoCoinListScreenState extends State<CryptoCoinListScreen> {
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  late MarketApiService marketApiService;
  List<CryptoCoinInfo> cryptoList = [];

  bool loading = false;
  bool book = false;

  SharedPreferences? prefs;

  @override
  void initState() {
    getData();
    initSharedPreferences();
    super.initState();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void getData() async {
    setState(() {
      loading = true;
    });
    cryptoList = await MarketApiService.getApiData();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider
        .of<ThemeProvider>(context)
        .darkMode;
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst
          .whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: darkMode
            ? ColorsConst.blackColor
            : ColorsConst.whiteColor,
        title: Text(
          'Crypto Market Cup',
          style: TextStyle(
            color: darkMode ? ColorsConst.whiteColor : ColorsConst.whiteColor,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SavedCoinsScreen()),
              );
            },
            icon: const Icon(Icons.save, color: ColorsConst.whiteColor),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search,
                  color: darkMode ? ColorsConst.whiteColor : ColorsConst
                      .whiteColor),
            ),
          ),
        ],
        backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst
            .blueColor,
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: cryptoList.length,
        itemBuilder: (context, index) {
          CryptoCoinInfo cryptoCoinInfo = cryptoList[index];
          bool isSaved = isCoinSaved(cryptoCoinInfo);
          return Slidable(
            key: ValueKey(cryptoCoinInfo.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    Share.share('');
                  },
                  icon: Icons.share,
                  backgroundColor: darkMode
                      ? ColorsConst.white54Color
                      : ColorsConst.whiteColor,
                  label: 'Share',
                ),
                SlidableAction(
                  onPressed: (context) async {
                    if (isSaved) {
                      removeCoin(cryptoCoinInfo);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Coin removed')));
                    } else {
                      saveCoin(cryptoCoinInfo);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Coin saved')));
                    }
                    setState(() {
                      isSaved = !isSaved;
                    });
                  },
                  icon: isSaved ? Icons.bookmark : Icons
                      .bookmark_border_outlined,
                  backgroundColor: darkMode
                      ? ColorsConst.white54Color
                      : ColorsConst.whiteColor,
                  label: isSaved ? 'Saved' : 'Save',
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      CryptoMaretDetailScreen(cryptoCoinInfo: cryptoCoinInfo)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.network(
                        cryptoCoinInfo.image.toString(),
                        height: 28,
                      ),
                      title: Text(
                        cryptoCoinInfo.name.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: darkMode ? ColorsConst.whiteColor : ColorsConst
                              .blackColor,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\u{20B9} ${NumberFormat('#,##0.0').format(
                                cryptoCoinInfo.currentPrice)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: darkMode
                                  ? ColorsConst.whiteColor
                                  : ColorsConst.blackColor,
                            ),
                          ),
                          Text(
                            'Market Cap ${formatMarketCap(
                                cryptoCoinInfo.marketCap!)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: darkMode
                                  ? ColorsConst.whiteColor
                                  : ColorsConst.gray800Color,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: darkMode ? Colors.blue[100] : Colors.blue[100],
                            ),
                            child: Text(
                              cryptoCoinInfo.marketCapRank.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: darkMode ? ColorsConst.blackColor : ColorsConst.whiteColor),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cryptoCoinInfo.symbol.toString(),
                            style: TextStyle(color: darkMode ? ColorsConst.white54Color : ColorsConst.gray800Color,fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${cryptoCoinInfo.marketCapChangePercentage24h}%',
                            style: TextStyle(
                              color: double.parse(cryptoCoinInfo.marketCapChangePercentage24h.toString()) >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
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
    );
  }

  bool isCoinSaved(CryptoCoinInfo coinInfo) {
    if (prefs != null) {
      List<String>? savedCoins = prefs!.getStringList('saved_coins');
      if (savedCoins != null) {
        for (String savedCoin in savedCoins) {
          Map<String, dynamic> savedCoinMap = jsonDecode(savedCoin);
          if (savedCoinMap['id'] == coinInfo.id) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void saveCoin(CryptoCoinInfo coinInfo) async {
    if (prefs != null) {
      List<String> savedCoins = prefs!.getStringList('saved_coins') ?? [];
      savedCoins.add(jsonEncode(coinInfo.toJson()));
      prefs!.setStringList('saved_coins', savedCoins);
    }
  }

  String formatMarketCap(num marketCap) {
    final units = ["", "K", "M", "B", "T"];
    int scale = 0;
    while (marketCap >= 1000 && scale < units.length - 1) {
      marketCap /= 1000;
      scale++;
    }
    final formattedValue = marketCap.toStringAsFixed(3);
    String trimmedValue = formattedValue.replaceAll(RegExp(r'\.?0+$'), '');
    trimmedValue += units[scale];
    return trimmedValue;
  }

  void removeCoin(CryptoCoinInfo coinInfo) async {
    if (prefs != null) {
      List<String>? savedCoins = prefs!.getStringList('saved_coins');
      if (savedCoins != null) {
        savedCoins.removeWhere((savedCoin) {
          Map<String, dynamic> savedCoinMap = jsonDecode(savedCoin);
          return savedCoinMap['id'] == coinInfo.id;
        });
        prefs!.setStringList('saved_coins', savedCoins);
      }
    }
  }
}


