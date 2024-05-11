import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/crypto/model/crypto_coin_info_model.dart';
import 'package:news_wave/crypto/ui/crypto_market_detail_screen.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/utils/colors_const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkCoinsScreen extends StatefulWidget {
  const BookMarkCoinsScreen({super.key});

  @override
  BookMarkCoinsScreenState createState() => BookMarkCoinsScreenState();
}

class BookMarkCoinsScreenState extends State<BookMarkCoinsScreen> {
  List<CryptoCoinInfo> savedCoins = [];

  @override
  void initState() {
    super.initState();
    loadSavedCoins();
  }

  void loadSavedCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCoinsJson = prefs.getStringList('saved_coins');
    if (savedCoinsJson != null) {
      setState(() {
        savedCoins = savedCoinsJson
            .map((json) => CryptoCoinInfo.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor:
          darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
      appBar: AppBar(
        titleSpacing: -6,
        backgroundColor:
            darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        surfaceTintColor:
            darkMode ? ColorsConst.blackColor : ColorsConst.whiteColor,
        title: Text(
          'BookMark Coins',
          style: TextStyle(
            color: darkMode ? ColorsConst.whiteColor : ColorsConst.whiteColor,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsConst.whiteColor,
          ),
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: savedCoins.isEmpty
          ?  Center(
              child: Text(
                'NO BOOKMARK COINS...',
                style: TextStyle(fontSize: 16,color: darkMode ? ColorsConst.whiteColor : ColorsConst.blackColor),
              ),
            )
          : ListView.builder(
              itemCount: savedCoins.length,
              itemBuilder: (context, index) {
                CryptoCoinInfo coinInfo = savedCoins[index];
                return Slidable(
                  key: ValueKey(coinInfo.id),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: darkMode
                                    ? ColorsConst.darkColor
                                    : ColorsConst.whiteColor,
                                surfaceTintColor: darkMode
                                    ? ColorsConst.darkColor
                                    : ColorsConst.whiteColor,
                                elevation: 100,
                                title: Text(
                                  'Alert!',
                                  style: TextStyle(
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor),
                                ),
                                content: Text(
                                  'Are you sure to Delete!',
                                  style: TextStyle(
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: darkMode
                                                ? ColorsConst.whiteColor
                                                : ColorsConst.blackColor),
                                      )),
                                  TextButton(
                                    onPressed: () async {
                                      removeSavedCoin(index);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: darkMode
                                              ? ColorsConst.whiteColor
                                              : ColorsConst.blackColor),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icons.delete,
                        foregroundColor: ColorsConst.redColor,
                        backgroundColor: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.whiteColor,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CryptoMaretDetailScreen(
                                    cryptoCoinInfo: coinInfo)),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                        coinInfo.image.toString(),
                        height: 30,
                      ),
                      title: Text(
                        coinInfo.name.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: darkMode
                              ? ColorsConst.whiteColor
                              : ColorsConst.blackColor,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color:
                                  darkMode ? Colors.blue[100] : Colors.blue[100],
                            ),
                            child: Text(
                              coinInfo.marketCapRank.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.blackColor
                                      : ColorsConst.whiteColor),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            coinInfo.symbol.toString(),
                            style: TextStyle(
                                color: darkMode
                                    ? ColorsConst.white54Color
                                    : ColorsConst.gray800Color,
                            fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${coinInfo.marketCapChangePercentage24h}%',
                            style: TextStyle(
                                color: double.parse(coinInfo.marketCapChangePercentage24h.toString()) >= 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\u{20B9} ${NumberFormat('#,##0.0').format(coinInfo.currentPrice)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: darkMode
                                  ? ColorsConst.whiteColor
                                  : ColorsConst.blackColor,
                            ),
                          ),
                          Text(
                            'Market Cap ${formatMarketCap(coinInfo.marketCap!)}',
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
                    ),
                  ),
                );
              },
            ),
    );
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

  void removeSavedCoin(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCoinsJson = prefs.getStringList('saved_coins');
    if (savedCoinsJson != null) {
      savedCoinsJson.removeAt(index);
      prefs.setStringList('saved_coins', savedCoinsJson);
      setState(() {
        savedCoins.removeAt(index);
      });
    }
  }
}

