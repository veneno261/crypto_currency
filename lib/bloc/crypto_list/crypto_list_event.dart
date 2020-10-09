part of 'crypto_list_bloc.dart';

@immutable
abstract class CryptoListEvent extends Equatable {

  const CryptoListEvent();
}

class FetchCryptoList extends CryptoListEvent {

  final String limit;
  const FetchCryptoList({@required this.limit}) : assert(limit != null);

  @override
  List<Object> get props => [limit];
}