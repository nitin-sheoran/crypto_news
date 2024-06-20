import 'package:flutter/cupertino.dart';
import 'package:news_wave/crypto/model/crypto_coin_info_model.dart';
import 'package:news_wave/crypto/service/market_api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoProvider extends ChangeNotifier {
  MarketApiService marketApiService;

  CryptoProvider({required this.marketApiService});

  SharedPreferences? prefs;
  bool loading = false;
  bool book = false;
  bool isSearching = false;
  String searchQuery = '';

  List<CryptoCoinInfo> cryptoList = [];
  List<CryptoCoinInfo> filteredCryptoList = [];
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(microseconds: 1000));
    refreshController.refreshCompleted();
    getData();
  }

  void onLoading() async {
    await Future.delayed(const Duration(microseconds: 1000));
    refreshController.loadComplete();
  }

  void getData() async {
      loading = true;
      notifyListeners();
    cryptoList = await MarketApiService.getApiData();
    filteredCryptoList = List.from(cryptoList);
      loading = false;
      notifyListeners();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void filterCoins(String keyword) {
      filteredCryptoList = cryptoList
          .where((coin) =>
      coin.name!.toLowerCase().contains(keyword.toLowerCase()) ||
          coin.name!.toUpperCase().contains(keyword.toUpperCase()))
          .toList();
notifyListeners();  }
}
