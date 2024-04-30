import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_wave/crypto/model/crypto_coin_info_model.dart';

class MarketApiService {
  static Future<List<CryptoCoinInfo>> getApiData() async {
    http.Response response = await http.get(
      Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=98&page=1&sparkline=false&locale=en'),
    );

    if (response.statusCode == 200) {
      List<dynamic> mapList = jsonDecode(response.body);
      List<CryptoCoinInfo> cryptoList = [];

      for (int i = 0; i < mapList.length; i++) {
        CryptoCoinInfo cryptoCoinInfo = CryptoCoinInfo.fromJson(mapList[i]);
        cryptoList.add(cryptoCoinInfo);
      }
      return cryptoList;
    } else {
      throw 'Something Went Wrong';
    }
  }
}
