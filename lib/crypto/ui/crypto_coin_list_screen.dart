import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/crypto/provider/crypto_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:news_wave/all_imports.dart';

class CryptoCoinListScreen extends StatefulWidget {
  const CryptoCoinListScreen({super.key});

  @override
  State<CryptoCoinListScreen> createState() => _CryptoCoinListScreenState();
}

class _CryptoCoinListScreenState extends State<CryptoCoinListScreen> {
  late CryptoProvider cryptoProvider;

  @override
  void initState() {
    cryptoProvider = Provider.of<CryptoProvider>(context,listen: false);
    cryptoProvider.getData();
    cryptoProvider.initSharedPreferences();
    SmartRefresher(
      controller: cryptoProvider.refreshController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor:
      darkMode ? ColorsConst.darkColor : ColorsConst.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor:
        darkMode ? ColorsConst.blackColor : ColorsConst.whiteColor,
        title: cryptoProvider.isSearching
            ? TextFormField(
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
            cryptoProvider.filterCoins(query);
          },
        )
            :Text(
          StringConst.cryptoMaretCap,
          style: TextStyle(
            color: darkMode ? ColorsConst.whiteColor : ColorsConst.whiteColor,
            fontSize: 20,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  cryptoProvider.isSearching ? Icons.close : Icons.search,
                  color: ColorsConst.whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    cryptoProvider.isSearching = !cryptoProvider.isSearching;
                    cryptoProvider.searchQuery = '';
                  });
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookMarkCoinsScreen()),
                  );
                },
                icon: const Icon(Icons.save, color: ColorsConst.whiteColor),
              ),
            ],
          ),
        ],
        backgroundColor:
        darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: Consumer<CryptoProvider>(
        builder: (context, provider, child) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: provider.refreshController,
            onRefresh: provider.onRefresh,
            onLoading: provider.onLoading,
            child: provider.loading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
              itemCount: provider.filteredCryptoList.length,
              itemBuilder: (context, index) {
                CryptoCoinInfo cryptoCoinInfo =
                provider.filteredCryptoList[index];
                bool isSaved = isCoinSaved(cryptoCoinInfo);
                return Slidable(
                  key: ValueKey(cryptoCoinInfo.id),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          Share.share(
                            ' ${StringConst.coinName} ${cryptoCoinInfo
                                .name}\n ${StringConst
                                .coinPrice} \u{20B9} ${NumberFormat('#,##0.0')
                                .format(
                                cryptoCoinInfo.currentPrice)}\n ${StringConst
                                .marketCap1} ${formatMarketCap(
                                cryptoCoinInfo.marketCap!)}',
                          );
                        },
                        icon: Icons.share,
                        backgroundColor: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.whiteColor,
                        label: StringConst.share,
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          if (isSaved) {
                            removeCoin(cryptoCoinInfo);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(StringConst.coinRemoved)));
                          } else {
                            saveCoin(cryptoCoinInfo);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(StringConst.coinBookMarks)));
                          }
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                        icon: isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        backgroundColor: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.whiteColor,
                        label: StringConst.coinBookMark,
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
                                    cryptoCoinInfo: cryptoCoinInfo)),
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
                                color: darkMode
                                    ? ColorsConst.whiteColor
                                    : ColorsConst.blackColor,
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  '${StringConst.marketCap} ${formatMarketCap(
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
                                    color: ColorsConst.blue100Color,
                                  ),
                                  child: Text(
                                    cryptoCoinInfo.marketCapRank
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: darkMode
                                            ? ColorsConst.blackColor
                                            : ColorsConst.whiteColor),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  cryptoCoinInfo.symbol.toString(),
                                  style: TextStyle(
                                      color: darkMode
                                          ? ColorsConst.white54Color
                                          : ColorsConst.gray800Color,
                                      fontSize: 12),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${cryptoCoinInfo
                                      .marketCapChangePercentage24h}%',
                                  style: TextStyle(
                                      color: double.parse(cryptoCoinInfo
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
      ),
    );
  }

  bool isCoinSaved(CryptoCoinInfo coinInfo) {
    if (cryptoProvider.prefs != null) {
      List<String>? savedCoins = cryptoProvider.prefs!.getStringList(StringConst.savedCoinsKey);
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

  void saveCoin(CryptoCoinInfo coinInfo) async {
    if (cryptoProvider.prefs != null) {
      List<String> savedCoins = cryptoProvider.prefs!.getStringList(StringConst.savedCoinsKey) ?? [];
      savedCoins.add(jsonEncode(coinInfo.toJson()));
      cryptoProvider.prefs!.setStringList(StringConst.savedCoinsKey, savedCoins);
    }
  }

  void removeCoin(CryptoCoinInfo coinInfo) async {
    if (cryptoProvider.prefs != null) {
      List<String>? savedCoins = cryptoProvider.prefs!.getStringList(StringConst.savedCoinsKey);
      if (savedCoins != null) {
        savedCoins.removeWhere((savedCoin) {
          Map<String, dynamic> savedCoinMap = jsonDecode(savedCoin);
          return savedCoinMap['id'] == coinInfo.id;
        });
        cryptoProvider.prefs!.setStringList(StringConst.savedCoinsKey, savedCoins);
      }
    }
  }
}

