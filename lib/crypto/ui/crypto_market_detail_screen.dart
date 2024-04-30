import 'package:flutter/material.dart';
import 'package:news_wave/crypto/model/crypto_coin_info_model.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:provider/provider.dart';

class CryptoMaretDetailScreen extends StatefulWidget {
  const CryptoMaretDetailScreen({required this.cryptoCoinInfo, super.key});

 final CryptoCoinInfo cryptoCoinInfo;

  @override
  State<CryptoMaretDetailScreen> createState() =>
      _CryptoMaretDetailScreenState();
}

class _CryptoMaretDetailScreenState extends State<CryptoMaretDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
      appBar: AppBar(
        titleSpacing: -8,
        surfaceTintColor: darkMode
            ? ColorsConst.blackColor
            : ColorsConst.whiteColor,
        title: Text(
          widget.cryptoCoinInfo.name.toString(),
          style:  TextStyle(color: darkMode
              ? ColorsConst.whiteColor
              : ColorsConst.whiteColor),
        ),
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios,
            color: darkMode
                ? ColorsConst.whiteColor
                : ColorsConst.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 880,
            decoration: BoxDecoration(
              color: darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Rank',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor,

                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.marketCapRank.toString(),style: TextStyle(color: darkMode
                        ? ColorsConst.whiteColor
                        : ColorsConst.blackColor,
                    ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                     ? ColorsConst.white54Color
                     : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.name.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Current Price',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.currentPrice.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Market Cap',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.marketCap.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Symbol',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.symbol.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'LastUpdate',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.lastUpdated.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'High24h',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.high24h.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Low24h',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.low24h.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Ath',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.ath.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'marketCapChange24h',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.high24h.toString(),
                      style: TextStyle(
                        color: darkMode
                            ? ColorsConst.whiteColor
                            : ColorsConst.blackColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'MaxSupply',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.atlChangePercentage.toString(),
                      style: TextStyle(
                        color: darkMode
                            ? ColorsConst.whiteColor
                            : ColorsConst.blackColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'TotalSupply',
                      style: TextStyle(
                        fontSize: 18,color: darkMode
                          ? ColorsConst.white54Color
                          : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.totalSupply.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'ATL',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.atl.toString(),
                      style: TextStyle(
                        color: darkMode
                            ? ColorsConst.whiteColor
                            : ColorsConst.blackColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color:darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'CirculatingSupply',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.priceChangePercentage24h.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                 Divider(color: darkMode
                    ? ColorsConst.white54Color
                    : ColorsConst.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Total Volume',
                      style: TextStyle(
                        fontSize: 18,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.blackColor
                      ),
                    ),
                    Text(
                      widget.cryptoCoinInfo.totalVolume.toString(),
                      style: TextStyle(color: darkMode
                          ? ColorsConst.whiteColor
                          : ColorsConst.blackColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
