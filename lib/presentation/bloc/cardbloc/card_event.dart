import 'package:equatable/equatable.dart';

import 'package:flutter_application_firebase/data/models/instrument.dart';


abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final Instrument item;

  AddItemToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final Instrument item;

  RemoveItemFromCart(this.item);

  @override
  List<Object> get props => [item];
}