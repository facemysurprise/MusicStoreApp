
import 'package:flutter_application_firebase/domain/repositories/instrument_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_firebase/data/repositories/shop_repository.dart';
import 'package:flutter_application_firebase/presentation/bloc/shop_bloc/shop_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/shop_bloc/shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final InstrumentRepository repository;

  ShopBloc({required this.repository}) : super(ShopInitial()) {
    on<LoadInstrumentsEvent>((event, emit) async {
      emit(ShopLoading());
      try {
        final instrumentsList = await repository.getInstrumentsStream().first;
        emit(ShopLoaded(instrumentsList.cast<Instrument>()));
      } catch (e) {
        print('Error loading instruments: $e');
        emit(ShopError());
      }
    });
  }
}