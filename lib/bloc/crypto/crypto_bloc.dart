import 'package:bloc/bloc.dart';
import 'package:crypto_currency/model/coin_info.dart';
import 'package:crypto_currency/repository/repository.dart';
import 'package:flutter/material.dart';

import 'crypto_barrel.dart';


class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {

  final Repository repository;
  CryptoBloc({@required this.repository}) : assert(repository != null), super(CryptoEmpty());

  CryptoState get initialState => CryptoEmpty();

  @override
  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    if(event is FetchCrypto) {
      yield CryptoLoading();

      try {
        final CoinInfo crypto = await repository.fetchSingleCoin(event.id);
        yield CryptoLoaded(crypto: crypto);
      } catch (err) {
        print(err);
        yield CryptoError();
      }
    }
  }
}