

import 'package:flutter_application_firebase/data/models/instrument.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedItems = List<Instrument>.from(currentState.items)..add(event.item);
      emit(CartLoaded(updatedItems));
    } else {
      emit(CartLoaded([event.item]));
    }
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedItems = currentState.items.where((item) => item.id != event.item.id).toList();
      emit(CartLoaded(updatedItems));
    }
  }
}