/*
 * Created by Emilio Dalla Torre on 17/08/21, 14:28.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 17/08/21, 14:28.
 */

import 'package:bookaround/models/report_model.dart';
import 'package:bookaround/references.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ReportHelper {
  static Future<void> reportBook(final String bookId, final String reporterUid) async {
    final ReportModel report = ReportModel(
      id: randomAlphaNumeric(20),
      content: bookId,
      type: ReportType.BOOK,
      reporterUid: reporterUid,
    );

    await References.reportsCollection.doc(report.id).set(report.toJson());
    debugPrint("Report ${report.id} creato.");
  }
}
