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
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint("La verifica è andata a buon fine!");
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("La verifica automatica non è andata a buon fine!");

          // Provider.of<LoginScreenState>(context, listen: false).setLoginStep(LoginStep.ERROR);
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint("Il codice è stato spedito!");
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

    while (!(await References.usersCollection.doc(credential.user!.uid).get()).exists) {
      await Future.delayed(Duration(seconds: 2));
    }

    debugPrint("Login effettuato con successo.");
  }
}
