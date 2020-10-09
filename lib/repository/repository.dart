import 'package:crypto_currency/model/barrel.dart';
import 'package:crypto_currency/model/coin_info.dart';
import 'package:crypto_currency/repository/api_client.dart';
import 'package:flutter/material.dart';

class Repository {
  final ApiClient apiClient;

  Repository({@required this.apiClient}) : assert(apiClient != null);

  Future<List<CryptocurrencyModel>> fetchCryptoList(limit) async {
    return await apiClient.fetchCryptoList(limit);
  }

  Future<CoinInfo> fetchSingleCoin(id) async {
    return await apiClient.fetchSingleCoin(id);
  }

  Future getConvertedPrice(id, amount, target) async {
    return await apiClient.getConvertedPrice(id, amount, target);
  }
}