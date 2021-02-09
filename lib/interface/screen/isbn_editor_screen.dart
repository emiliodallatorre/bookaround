import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/isbn_model.dart';
import 'package:bookaround/resources/helper/isbn_helper.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class IsbnEditorScreen extends StatelessWidget {
  static const String route = "/isbnEditorScreen";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  IsbnModel isbn;
  bool shownFirstFrame = false;

  @override
  Widget build(BuildContext context) {
    if (isbn == null) {
      isbn = IsbnModel(id: randomAlphaNumeric(20), isbn: ModalRoute.of(context).settings.arguments as String);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!shownFirstFrame) {
          shownFirstFrame = true;

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(S.current.responsibleUse),
              content: Text(S.current.responsibleUseExtended),
              actions: [
                ElevatedButton(
                  child: Text(S.current.proceed),
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            ),
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(S.current.manualAdd)),
      body: buildBody(),
      persistentFooterButtons: [
        ElevatedButton(
          child: Text(S.current.save),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();

              IsbnHelper.createIsbn(isbn);
            }
          },
        ),
      ],
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
