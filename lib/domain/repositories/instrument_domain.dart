abstract class IInstrumentRepository {
  Stream<List<Instrument>> getInstrumentsStream();
}

class Instrument {
  final String id;
  final String name;
  final String photoUrl;
  final String price;

  Instrument({required this.id, required this.name, required this.photoUrl, required this.price});

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      id: json['id'].toString(),
      name: json['name'], 
      photoUrl: json['photo_url'], 
      price: json['price'],
    );
  }
}