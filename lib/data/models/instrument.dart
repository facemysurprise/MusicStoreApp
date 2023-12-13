import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'instrument.g.dart';

@JsonSerializable()
class Instrument {
  final String id;
  final String name;
  final String photoUrl;
  final String price;


  Instrument({required this.id, required this.name, required this.photoUrl, required this.price});

 factory Instrument.fromJson(Map<String, dynamic> json) {
  return Instrument(
    id: json['id']?.toString() ?? 'default_id', 
    name: json['name'] ?? 'default_name',
    photoUrl: json['photo_url'] ?? 'default_photo_url',
    price: json['price'] ?? 'default_price',
  );
}
}

@RestApi(baseUrl: "https://earnest-cooler-403412-default-rtdb.firebaseio.com/")
abstract class InstrumentApi {
  factory InstrumentApi(Dio dio, {String baseUrl}) = _InstrumentApi;

  @GET('/instruments.json')
  Future<List<Instrument>> getInstruments();
}