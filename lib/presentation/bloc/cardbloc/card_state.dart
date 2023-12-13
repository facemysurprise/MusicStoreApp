import 'package:equatable/equatable.dart';
import 'package:flutter_application_firebase/data/models/instrument.dart';



abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Instrument> items;

  CartLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class CartError extends CartState {}
