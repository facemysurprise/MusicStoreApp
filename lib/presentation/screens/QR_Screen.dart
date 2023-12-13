import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/core/generated/locale_keys.g.dart';
import 'package:flutter_application_firebase/presentation/bloc/qrbloc/qrscreen_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/qrbloc/qrscreen_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/qrbloc/qrscreen_state.dart';
import 'package:flutter_application_firebase/presentation/themes/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    ThemeData themeData = Theme.of(context).copyWith(
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.primaryColor
    );

    return Theme(
      data: themeData,
      child: BlocProvider(
        create: (context) => QrScreenBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.qr.tr()),
            backgroundColor: AppColors.primaryColor, 
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: AppColors.primaryColor,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: BlocBuilder<QrScreenBloc, QrScreenState>(
                    builder: (context, state) {
                      if (state is QrScanSuccess) {
                        return Text(
                          'Data: ${state.qrData}',
                          style: TextStyle(fontSize: 20, color: Colors.purple), 
                        );
                      }
                      return Text(
                        LocaleKeys.qr2.tr(),
                        style: TextStyle(color: Colors.purple), 
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        BlocProvider.of<QrScreenBloc>(context).add(QrScanEvent(scanData.code!));
        controller.pauseCamera();
      }
    });
  }
}