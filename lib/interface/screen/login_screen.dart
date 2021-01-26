import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/home_screen.dart';
import 'package:bookaround/resources/helper/auth_helper.dart';
import 'package:code_field/code_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "/loginScreen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginScreenState(),
      builder: (BuildContext context, Widget child) => WillPopScope(
          onWillPop: () {
            LoginScreenState state = Provider.of<LoginScreenState>(context, listen: false);

            Future<bool> pop = Future.value(false);

            switch (state.loginStep) {
              case LoginStep.SIGN_IN:
                pop = Future.value(true);
                break;
              case LoginStep.INSERT_CODE:
              case LoginStep.ERROR:
                state.setLoginStep(LoginStep.SIGN_IN);
                break;
            }

            return pop;
          },
          child: Scaffold(body: _buildBody(context))),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<LoginScreenState>(
          builder: (BuildContext context, LoginScreenState state, Widget child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("🦊 " + S.current.login, style: Theme.of(context).textTheme.headline5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: state.loginStep == LoginStep.SIGN_IN
                      ? TextField(
                          controller: state.numberController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(labelText: S.current.phoneNumber, prefixText: "+39"),
                        )
                      : InputCodeField(
                          control: state.codeController,
                          autofocus: true,
                          decoration: InputCodeDecoration(textStyle: Theme.of(context).textTheme.headline5),
                        ),
                ),
                ElevatedButton(
                  child: Text(S.current.proceed),
                  onPressed: () {
                    switch (state.loginStep) {
                      case LoginStep.SIGN_IN:
                        AuthHelper.sendSmsCode("+39" + state.numberController.text, context);
                        break;
                      case LoginStep.INSERT_CODE:
                        state.loginWithCredential(context);
                        break;
                      case LoginStep.ERROR:
                        // TODO: Handle this case.
                        break;
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

enum LoginStep { SIGN_IN, INSERT_CODE, ERROR }

class LoginScreenState extends ChangeNotifier {
  LoginStep loginStep = LoginStep.SIGN_IN;

  TextEditingController numberController = TextEditingController();
  InputCodeControl codeController = InputCodeControl();

  String verificationCode;

  void setLoginStep(LoginStep newLoginStep) {
    this.loginStep = newLoginStep;

    notifyListeners();
  }

  void setVerificationCode(String verificationCode) {
    this.verificationCode = verificationCode;

    notifyListeners();
  }

  Future<void> loginWithCredential(BuildContext context) async {
    await AuthHelper.loginWithCredential(this.verificationCode, this.codeController.value);
    Navigator.of(context).pushReplacementNamed(HomeScreen.route);
  }
}
