import 'dart:convert';

import 'package:crypto_currency/model/barrel.dart';
import 'package:crypto_currency/model/coin_info.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'authentication.dart';

class ApiClient {

  final http.Client httpClient;

  ApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);


  Future<List<CryptocurrencyModel>> fetchCryptoList(limit) async {
    final url = Auth().urlCurrency+'/listings/latest?start=1&limit=$limit&convert=USD';

    final response = await httpClient.get(url, headers: {
      "Accepts": "application/json",
      "X-CMC_PRO_API_KEY": Auth().token
    });

    if(response.statusCode != 200){
      throw new Exception('error getting crypto list');
    }

    final json = jsonDecode(response.body);
    return CryptocurrencyModel().fromJsonToList(json['data']);
  }

  Future<CoinInfo> fetchSingleCoin(id) async {
    final url = Auth().urlCurrency+'/info?id=$id';

    final response = await httpClient.get(url, headers: {
      "Accepts": "application/json",
      "X-CMC_PRO_API_KEY": Auth().token
    });

    if(response.statusCode != 200){
      throw new Exception('error getting info');
    }

    final json = jsonDecode(response.body);
    return CoinInfo.fromJson(json['data'][id.toString()]);
  }

  Future getConvertedPrice(id, amount, target) async {
    final url = Auth().urlTools+'/price-conversion?amount=$amount&id=$id&convert=$target';

    final response = await httpClient.get(url, headers: {
      "Accepts": "application/json",
      "X-CMC_PRO_API_KEY": Auth().token
    });

    if(response.statusCode != 200){
      throw new Exception('error getting info');
    }

    final json = jsonDecode(response.body);
    return json['data']['quote'][target]['price'];
  }
}