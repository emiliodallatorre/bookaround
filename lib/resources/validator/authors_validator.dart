import 'package:bookaround/resources/helper/author_helper.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthorsValidator extends TextFieldValidator {
  AuthorsValidator(String errorText) : super(errorText);

  @override
  bool isValid(String value) => AuthorHelper.parseAuthors(value).isNotEmpty;
}
