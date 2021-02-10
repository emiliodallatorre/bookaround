import 'dart:io';

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/isbn_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/author_helper.dart';
import 'package:bookaround/resources/helper/isbn_helper.dart';
import 'package:bookaround/resources/helper/upload_helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class IsbnEditorScreen extends StatefulWidget {
  static const String route = "/isbnEditorScreen";

  @override
  _IsbnEditorScreenState createState() => _IsbnEditorScreenState();
}

class _IsbnEditorScreenState extends State<IsbnEditorScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  IsbnModel isbn;
  bool shownFirstFrame = false;
  bool working = false;

  @override
  Widget build(BuildContext context) {
    if (isbn == null) {
      isbn = IsbnModel(
        id: randomAlphaNumeric(20),
        isbn: ModalRoute.of(context).settings.arguments as String,
        authorUid: Provider.of<UserModel>(context, listen: false).uid,
      );

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
          onPressed: () async {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();

              if (isbn.coverUrl == null) {
                ImageSource wantedSource = await showDialog<ImageSource>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(S.current.chooseSource),
                    content: Text(S.current.chooseSourceExtended),
                    actions: [
                      ElevatedButton(
                        child: Text(S.current.sourceCamera),
                        onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                      ),
                      ElevatedButton(
                        child: Text(S.current.sourceGallery),
                        onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                      ),
                    ],
                  ),
                );

                // L'utente non ha selezionato con cosa acquisire l'immagine.
                if (wantedSource == null) return;

                PickedFile pickedFile = await ImagePicker().getImage(source: wantedSource);

                // L'utente non ha infine acquisito l'immagine.
                if (pickedFile == null) return;

                setState(() => working = true);
                isbn.coverUrl = await UploadHelper.uploadFile(References.bookCovers, File(pickedFile.path), isbn.isbn);
                setState(() => working = false);
              }

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
                if (isbn.coverUrl != null)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(isbn.coverUrl, fit: BoxFit.contain),
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: S.current.title),
                  onSaved: (String value) => isbn.title = value,
                  validator: RequiredValidator(errorText: S.current.requiredField),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: S.current.authors),
                  onSaved: (String value) => isbn.authors = AuthorHelper.parseAuthors(value),
                  validator: RequiredValidator(errorText: S.current.wrongField),
                  textCapitalization: TextCapitalization.words,
                ),
                TextFormField(
                  initialValue: isbn.isbn,
                  decoration: InputDecoration(labelText: S.current.isbn),
                  enabled: false,
                  readOnly: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
