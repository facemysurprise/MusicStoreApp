import 'package:flutter_bloc/flutter_bloc.dart';
import 'qrscreen_event.dart';
import 'qrscreen_state.dart';

class QrScreenBloc extends Bloc<QrScreenEvent, QrScreenState> {
  QrScreenBloc() : super(QrInitial()) {
    on<QrScanEvent>((event, emit) {
      emit(QrScanSuccess(event.qrCode));
    });
  }
}