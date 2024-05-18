import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/crypto/model/crypto_coin_info_model.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/utils/colors_const.dart';
import 'package:news_wave/utils/string_const.dart';
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
    DateTime lastUpdatedDate = DateTime.parse(widget.cryptoCoinInfo.lastUpdated.toString());
    String formattedDate = DateFormat('dd MMM yyyy').format(lastUpdatedDate);

    return Scaffold(
      backgroundColor:
          darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
      appBar: AppBar(
        titleSpacing: -8,
        surfaceTintColor:
            darkMode ? ColorsConst.blackColor : ColorsConst.whiteColor,
        title: Text(
          widget.cryptoCoinInfo.name.toString(),
          style: TextStyle(
              color:
                  darkMode ? ColorsConst.whiteColor : ColorsConst.whiteColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkMode ? ColorsConst.whiteColor : ColorsConst.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor:
            darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 8),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: MarketStateChart(
                marketCapChangePercentage24h:
                    widget.cryptoCoinInfo.marketCapChangePercentage24h!, date: formattedDate,
              ),
            ),
            Expanded(
              child: Card(
                elevation: 10,
                shadowColor: darkMode ? ColorsConst.black54Color : ColorsConst.whiteColor,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: 760,
                  decoration: BoxDecoration(
                    color: darkMode
                        ? ColorsConst.darkColor
                        : ColorsConst.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringConst.rank,
                              style: TextStyle(
                                fontSize: 14,
                                color: darkMode
                                    ? ColorsConst.white54Color
                                    : ColorsConst.blackColor,
                              ),
                            ),
                            Text(
                              widget.cryptoCoinInfo.marketCapRank.toString(),
                              style: TextStyle(
                                color: darkMode
                                    ? ColorsConst.whiteColor
                                    : ColorsConst.blackColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringConst.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              widget.cryptoCoinInfo.name.toString(),
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringConst.currentPrice,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              '\u{20B9} ${NumberFormat('#,##0.0').format(widget.cryptoCoinInfo.currentPrice)}',
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringConst.marketCap,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              formatMarketCap(widget.cryptoCoinInfo.marketCap!),
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              StringConst.symbol,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              widget.cryptoCoinInfo.symbol.toString(),
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'LastUpdate',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High24h',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              '\u{20B9} ${NumberFormat('#,##0.0').format(widget.cryptoCoinInfo.high24h)}',
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Low24h',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              '\u{20B9} ${NumberFormat('#,##0.0').format(widget.cryptoCoinInfo.low24h)}',
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MCCPercentage24h',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              '${widget.cryptoCoinInfo.marketCapChangePercentage24h}%',
                              style: TextStyle(
                                  color: double.parse(widget.cryptoCoinInfo
                                              .marketCapChangePercentage24h
                                              .toString()) >=
                                          0
                                      ? ColorsConst.greenColor
                                      : ColorsConst.redColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MaxSupply',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              widget.cryptoCoinInfo.atlChangePercentage
                                  .toString(),
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TotalSupply',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              widget.cryptoCoinInfo.totalSupply.toString(),
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ATL',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              widget.cryptoCoinInfo.atl.toString(),
                              style: TextStyle(
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PriceChangePerc24h',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              '${widget.cryptoCoinInfo.priceChangePercentage24h}%',
                              style: TextStyle(
                                  color: double.parse(widget.cryptoCoinInfo
                                              .priceChangePercentage24h
                                              .toString()) >=
                                          0
                                      ? ColorsConst.greenColor
                                      : ColorsConst.redColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Divider(
                            color: darkMode
                                ? ColorsConst.white54Color
                                : Colors.black12),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Volume',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.white54Color
                                      : ColorsConst.blackColor),
                            ),
                            Text(
                              widget.cryptoCoinInfo.totalVolume.toString(),
                              style: TextStyle(
                                  color: darkMode
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
            ),
          ],
        ),
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
}


class MarketStateChart extends StatelessWidget {
  final double marketCapChangePercentage24h;
  final String date;

  const MarketStateChart({
    Key? key,
    required this.marketCapChangePercentage24h,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPositive = marketCapChangePercentage24h >= 0;
    Color color = isPositive ? Colors.green : Colors.red;

    return Column(
      children: [
        Text(
          date,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          child: CustomPaint(
            size: Size(100, 100), // Adjust size as needed
            painter: MarketStateChartPainter(
              percentageChange: marketCapChangePercentage24h,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          '${marketCapChangePercentage24h.toStringAsFixed(2)}%',
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}

class MarketStateChartPainter extends CustomPainter {
  final double percentageChange;
  final Color color;

  MarketStateChartPainter({
    required this.percentageChange,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double lineHeight = percentageChange.abs() * size.height;

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(centerX, centerY + lineHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

