import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_firebase/domain/repositories/instrument_domain.dart';


class InstrumentRepository implements IInstrumentRepository {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  Stream<List<Instrument>> getInstrumentsStream() {
    DatabaseReference ref = database.ref('instruments');

    return ref.onValue.map((event) {
      final dynamic value = event.snapshot.value;
      final List<Instrument> instrumentsList = [];
      if (value is List) {
        for (var item in value) {
          if (item is Map) {
            final instrumentMap = Map<String, dynamic>.from(item);
            final instrument = Instrument.fromJson(instrumentMap);
            instrumentsList.add(instrument);
          }
        }
      } else {
        print('The retrieved Firebase value is not a List. Actual type: ${value.runtimeType}');
      }
      return instrumentsList;
    });
  }
}