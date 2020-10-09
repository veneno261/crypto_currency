import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_currency/model/barrel.dart';
import 'package:crypto_currency/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {

  final Repository repository;
  CryptoListBloc({@required this.repository})
      : assert(repository != null), super(CryptoListState());

  @override
  Stream<CryptoListState> mapEventToState(
    CryptoListEvent event,
  ) async* {
    if(event is FetchCryptoList){
      yield await _mapListFetchedToState(state, event.limit);
    }
  }

  Future<CryptoListState> _mapListFetchedToState(CryptoListState state, String limit) async {

    try {

      final List<CryptocurrencyModel> response = await repository
          .fetchCryptoList(limit);

      return state.copyWith(
          status: AdvertiseStatus.success,
          items: List.of(response)
      );

    } catch(err) {
      return state.copyWith(
          status: AdvertiseStatus.failure,
          err: err
      );

    }

  }

}
