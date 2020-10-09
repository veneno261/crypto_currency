import 'package:crypto_currency/model/coin_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object> get props => [];
}

class CryptoEmpty extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {

  final CoinInfo crypto;

  const CryptoLoaded({@required this.crypto}) : assert(crypto != null);

  @override
  List<Object> get props => [crypto];

}

class CryptoError extends CryptoState {}