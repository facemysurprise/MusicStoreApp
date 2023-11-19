abstract class QrScreenEvent {}

class QrScanEvent extends QrScreenEvent {
  final String qrCode;
  QrScanEvent(this.qrCode);
}