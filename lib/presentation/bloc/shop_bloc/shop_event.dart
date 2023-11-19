

import 'package:flutter_application_firebase/domain/repositories/instrument_domain.dart';

abstract class ShopEvent {}

class LoadInstrumentsEvent extends ShopEvent {}

class InstrumentsUpdated extends ShopEvent {
  final List<Instrument> instruments;

  InstrumentsUpdated(this.instruments);
}

class InstrumentsErrorEvent extends ShopEvent {
  final String error;

  InstrumentsErrorEvent(this.error);
}