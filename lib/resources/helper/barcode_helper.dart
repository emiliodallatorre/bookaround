import 'package:bookaround/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeHelper {
  static Future<String> readBarcode(BuildContext context) async {
    String newIsbn = await FlutterBarcodeScanner.scanBarcode(
      "#009688",
      S.of(context).cancelScan,
      true,
      ScanMode.BARCODE,
    );
    if (newIsbn != "-1") {
      debugPrint("Scansionato $newIsbn.");
      return newIsbn;
    } else
      return null;
  }
}
