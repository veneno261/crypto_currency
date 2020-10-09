part of 'crypto_list_bloc.dart';

enum AdvertiseStatus { initial, success, failure }

@immutable
class CryptoListState extends Equatable {

  /// fetched advertises store in this list
  final List<CryptocurrencyModel> items;

  /// store the fetch event status
  final AdvertiseStatus status;

  /// get any type of exception
  final err;

  const CryptoListState({
    this.items = const <CryptocurrencyModel>[],
    this.status = AdvertiseStatus.initial,
    this.err
  });

  CryptoListState copyWith({
    AdvertiseStatus status,
    List<CryptocurrencyModel> items,
    err
  }) {
    return CryptoListState(
        status: status ?? this.status,
        items: items ?? this.items,
        err: err ?? this.err
    );
  }


  @override
  List<Object> get props => [items, status, err];
}
