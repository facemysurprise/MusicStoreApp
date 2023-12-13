import 'package:dio/dio.dart';
import 'package:flutter_application_firebase/data/models/instrument.dart';


class InstrumentRepository implements IInstrumentRepository {
  final InstrumentApi api;

  InstrumentRepository() : api = InstrumentApi(Dio());

  @override
  Stream<List<Instrument>> getInstrumentsStream() async* {
    try {
      final instruments = await api.getInstruments();
      yield instruments;
    } catch (e) {
      print('Error fetching instruments: $e');
      yield [];
    }
  }
}
abstract class IInstrumentRepository {
  Stream<List<Instrument>> getInstrumentsStream();
}