/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 19/03/21, 19:09
 */

import 'package:bookaround/resources/helper/author_helper.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthorsValidator extends TextFieldValidator {
  AuthorsValidator(String errorText) : super(errorText);

  @override
  bool isValid(String? value) => AuthorHelper.parseAuthors(value).isNotEmpty;
}
