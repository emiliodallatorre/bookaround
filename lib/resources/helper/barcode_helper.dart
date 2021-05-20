/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 26/03/21, 11:48
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeHelper {
  static Future<String?> readBarcode(BuildContext context) async {
    String newIsbn = await FlutterBarcodeScanner.scanBarcode(
      "#009688",
      S.of(context).cancelScan,
      true,
      ScanMode.BARCODE,
    );
    // debugPrint(newIsbn);
    if (newIsbn != "-1") {
      debugPrint("Scansionato $newIsbn.");
      return newIsbn;
    } else
      return null;
  }
}
