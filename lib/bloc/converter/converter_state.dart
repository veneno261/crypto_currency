part of 'converter_bloc.dart';

@immutable
abstract class ConverterState extends Equatable {

  const ConverterState();

  @override
  List<Object> get props => [];
}

class ConverterEmpty extends ConverterState {}

class ConverterLoading extends ConverterState {}

class ConverterLoaded extends ConverterState {

  final dynamic price;

  ConverterLoaded({@required this.price}) : assert(price != null);

  @override
  List<Object> get props => [price];

}

class ConverterError extends ConverterState {}
