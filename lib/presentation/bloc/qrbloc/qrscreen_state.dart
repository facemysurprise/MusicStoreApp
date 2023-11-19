abstract class QrScreenState {}

class QrInitial extends QrScreenState {}

class QrScanSuccess extends QrScreenState {
  final String qrData;
  QrScanSuccess(this.qrData);
}