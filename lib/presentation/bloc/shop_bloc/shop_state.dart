

import 'package:flutter_application_firebase/data/models/instrument.dart';

abstract class ShopState {}
class ShopInitial extends ShopState {}
class ShopLoading extends ShopState {}
class ShopLoaded extends ShopState {
  final List<Instrument> instruments;

  ShopLoaded(this.instruments);
}
class ShopError extends ShopState {}