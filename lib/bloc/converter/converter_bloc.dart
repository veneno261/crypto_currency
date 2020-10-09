import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_currency/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {

  final Repository repository;
  ConverterBloc({@required this.repository}) : assert(repository != null), super(ConverterEmpty());

  ConverterState get initialState => ConverterEmpty();

  @override
  Stream<ConverterState> mapEventToState(ConverterEvent event) async* {

    if(event is FetchConvertPrice){
      yield ConverterLoading();

      try {
        final response = await repository.getConvertedPrice(event.id, event.amount, event.target);
        yield ConverterLoaded(price: response);
      } catch (err) {
        yield ConverterError();
      }
    }

    if(event is ClearConvertPrice){
      yield ConverterEmpty();
    }

  }
}
