/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthHelper {
  static Future<ConfirmationResult?> sendSmsCode(String phoneNumber, BuildContext context) async {
    debugPrint("Provo a verificare $phoneNumber.");

    Provider.of<LoginScreenState>(context, listen: false).setLoginStep(LoginStep.INSERT_CODE);

    if (!kIsWeb)
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // forceResendingToken: ,
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint("La verifica è andata a buon fine!");

          final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

          context.read<LoginScreenState>().codeController.value = credential.smsCode;
          context.read<LoginScreenState>().autoVerification = true;
          await waitForUser(userCredential.user!.uid);
          await context.read<LoginScreenState>().goHome(context);
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("La verifica automatica non è andata a buon fine!");

          // Provider.of<LoginScreenState>(context, listen: false).setLoginStep(LoginStep.ERROR);
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint("Il codice è stato spedito, il codice di verifica è $verificationId!");
          Provider.of<LoginScreenState>(context, listen: false).setVerificationCode(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("È passato il tempo massimo per la verifica automatica.");
        },
      );
    else {
      final ConfirmationResult confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
      return confirmationResult;
    }
  }

  static Future<void> loginWithCredential(String? verificationId, String smsCode, [ConfirmationResult? confirmationResult]) async {
    debugPrint("Provo a verificare $smsCode.");

    UserCredential? credential;
    if (!kIsWeb) {
      assert(verificationId != null);
      final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: smsCode);
      credential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    } else {
      assert(confirmationResult != null);
      debugPrint("Confermiamo con $confirmationResult.");
      credential = await confirmationResult!.confirm(smsCode);
    }

    await waitForUser(credential.user!.uid);

    debugPrint("Login effettuato con successo.");
  }

  static Future<void> waitForUser(final String uid) async {
    while (!(await References.usersCollection.doc(uid).get()).exists) {
      await Future.delayed(Duration(seconds: 2));
    }
  }
}
