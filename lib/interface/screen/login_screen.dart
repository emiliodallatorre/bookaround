/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/assets.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/auth_helper.dart';
import 'package:bookaround/resources/helper/init_helper.dart';
import 'package:bookaround/resources/helper/notifications_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:input_code_field/input_code_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "/loginScreen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginScreenState(),
      builder: (BuildContext context, Widget? child) => WillPopScope(
        onWillPop: () {
          LoginScreenState state = Provider.of<LoginScreenState>(context, listen: false);

          Future<bool> pop = Future.value(false);

          switch (state.loginStep) {
            case LoginStep.SIGN_IN:
              pop = Future.value(true);
              break;
            case LoginStep.INSERT_CODE:
              state.setLoginStep(LoginStep.SIGN_IN);
              break;
          }

          return pop;
        },
        child: Scaffold(
          key: Provider.of<LoginScreenState>(context).scaffoldKey,
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Consumer<LoginScreenState>(
            builder: (BuildContext context, LoginScreenState state, Widget? child) => Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Visibility(
                      visible: state.loginStep == LoginStep.INSERT_CODE,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => state.setLoginStep(LoginStep.SIGN_IN),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.logo, fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width / 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.current.login, style: Theme.of(context).textTheme.headlineSmall),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: state.loginStep == LoginStep.SIGN_IN
                                  ? /* TextField(
                                      controller: state.numberController,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      decoration: InputDecoration(labelText: S.current.phoneNumber, prefixText: "+39"),
                                    ) */
                                  InternationalPhoneNumberInput(
                                      inputDecoration: InputDecoration(labelText: S.current.phoneNumber),
                                      textFieldController: state.numberController,
                                      countries: ["IT", "FR"],
                                      onInputChanged: (PhoneNumber phoneNumber) {
                                        state.phoneNumber = phoneNumber.phoneNumber;
                                      },
                                    )
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InputCodeField(
                                          control: state.codeController,
                                          autofocus: true,
                                          decoration: InputCodeDecoration(textStyle: Theme.of(context).textTheme.headlineSmall),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(S.current.insertSmsCode, style: Theme.of(context).textTheme.bodySmall),
                                      ],
                                    ),
                            ),
                            ElevatedButton(
                              child: Text(S.current.proceed),
                              onPressed: () async {
                                switch (state.loginStep) {
                                  case LoginStep.SIGN_IN:
                                    final ConfirmationResult? confirmationResult = await AuthHelper.sendSmsCode(state.phoneNumber!, context);
                                    if (kIsWeb) state.setConfirmationResult(confirmationResult);
                                    break;
                                  case LoginStep.INSERT_CODE:
                                    state.loginWithCredential(context);
                                    break;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum LoginStep { SIGN_IN, INSERT_CODE }

class LoginScreenState extends ChangeNotifier {
  LoginStep loginStep = LoginStep.SIGN_IN;

  TextEditingController numberController = TextEditingController();
  String? phoneNumber;
  InputCodeControl codeController = InputCodeControl();

  String? verificationCode;
  bool autoVerification = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ConfirmationResult? confirmationResult;

  void setLoginStep(LoginStep newLoginStep) {
    this.loginStep = newLoginStep;

    notifyListeners();
  }

  void setVerificationCode(String verificationCode) {
    this.verificationCode = verificationCode;

    notifyListeners();
  }

  Future<void> loginWithCredential(BuildContext context) async {
    if (this.autoVerification) return;

    try {
      if (kIsWeb) debugPrint("L'ambiente è web, confirmationResult è $confirmationResult.");

      await AuthHelper.loginWithCredential(this.verificationCode, this.codeController.value, confirmationResult);
      await goHome(context);
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.wrongCode)));
      codeController.clear();
    }
  }

  Future<void> goHome(BuildContext context) async {
    await InitHelper(context).initializeUser();
    await NotificationsHelper.initializeNotifications(Provider.of<UserModel>(context, listen: false), context);

    Navigator.of(context).pushReplacementNamed(ProfileEditorScreen.route);
  }

  void setConfirmationResult(ConfirmationResult? confirmationResult) => this.confirmationResult = confirmationResult;
}
