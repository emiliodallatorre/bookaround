import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/user_avatar.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class ProfileEditorScreen extends StatelessWidget {
  static const String route = "/profileEditorScreen";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.editProfile)),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel currentUser, Widget child) => Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Row(children: [Spacer(), Expanded(child: UserAvatar(user: currentUser)), Spacer()]),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: S.current.name),
                        initialValue: currentUser.name,
                        onSaved: (String value) => currentUser.name = value,
                        validator: RequiredValidator(errorText: S.current.requiredField),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: S.current.surname),
                        initialValue: currentUser.surname,
                        onSaved: (String value) => currentUser.surname = value,
                        validator: RequiredValidator(errorText: S.current.requiredField),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: S.current.city),
                        initialValue: currentUser.city,
                        onSaved: (String value) => currentUser.city = value,
                        validator: RequiredValidator(errorText: S.current.requiredField),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: S.current.phoneNumber),
                        initialValue: currentUser.phoneNumber,
                        readOnly: true,
                        enabled: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text(S.current.save),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                await currentUser.updateOnServer();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
