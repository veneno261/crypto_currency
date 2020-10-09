import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class CryptoEvent extends Equatable{
  const CryptoEvent();
}

class FetchCrypto extends CryptoEvent {

  final id;
  const FetchCrypto({@required this.id});

  @override
  List<Object> get props => [id];
}