part of 'converter_bloc.dart';

@immutable
abstract class ConverterEvent extends Equatable {

  const ConverterEvent();
}

class FetchConvertPrice extends ConverterEvent{

  final String amount;
  final String id;
  final String target;

  const FetchConvertPrice({
    @required this.amount,
    @required this.id,
    @required this.target
  }) : assert(amount != null), assert(id != null), assert(target != null);

  @override
  List<Object> get props => [id, amount, target];

}

class ClearConvertPrice extends ConverterEvent{

  const ClearConvertPrice();

  @override
  List<Object> get props => [];
}
