/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'dart:io';

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_cover.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/place_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:bookaround/resources/helper/geocoding_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class BookEditorScreen extends StatefulWidget {
  static const String route = "/bookEditorScreen";

  @override
  _BookEditorScreenState createState() => _BookEditorScreenState();
}

class _BookEditorScreenState extends State<BookEditorScreen> {
  BookModel? book;
  TextEditingController locationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool saved = false;

  @override
  Widget build(BuildContext context) {
    if (book == null) {
      book = ModalRoute.of(context)!.settings.arguments as BookModel;
      if (book!.location != null) locationController.text = book!.location!.description!;
    }

    return WillPopScope(
      onWillPop: () async {
        debugPrint("Riflettiamo sul pop...");

        if (saved) {
          return Future.value(true);
        } else {
          if (formKey.currentState!.validate()) {
            return await saveBook();
          }

          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: _buildBody(context),
        persistentFooterButtons: [
          ElevatedButton(
            child: Text(S.current.save),
            onPressed: () async {
              bool result = await saveBook();

              if (result) Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        BookCover(book: book!),
        CheckboxListTile(
          value: book!.pencil,
          onChanged: (bool? value) => setState(() => book!.pencil = value!),
          title: Text(S.current.pencil),
        ),
        CheckboxListTile(
          value: book!.highlighting,
          onChanged: (bool? value) => setState(() => book!.highlighting = value!),
          title: Text(S.current.highlight),
        ),
        CheckboxListTile(
          value: book!.pen,
          onChanged: (bool? value) => setState(() => book!.pen = value!),
          title: Text(S.current.pen),
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  validator: RequiredValidator(errorText: S.current.requiredField),
                  controller: locationController,
                  decoration: InputDecoration(labelText: S.current.whereIsBook),
                  onTap: () async {
                    Prediction? prediction = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: References.googleApiKey,
                      mode: Mode.overlay,
                      language: Platform.localeName.split("_").first,
                      components: [
                        Component(Component.country, "it"),
                        Component(Component.country, "fr"),
                      ],
                    );

                    if (prediction != null) {
                      debugPrint("Il libro si trova a ${prediction.description}.");
                      locationController.text = prediction.description!;

                      book!.location = PlaceModel.fromPrediction(prediction);
                      book!.locationData = await GeocodingHelper.decodeAddress(book!.location!.description!);

                      setState(() {});
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: S.current.note, alignLabelWithHint: true),
                  textInputAction: TextInputAction.done,
                  initialValue: book!.note,
                  onSaved: (String? value) => setState(() => book!.note = value!),
                  minLines: 4,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> saveBook() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await BookHelper.updateBook(book!);
      await sellBooksBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!, Provider.of<UserModel>(context, listen: false).blockedUids!);

      saved = true;

      return true;
    }
    return false;
  }
}
