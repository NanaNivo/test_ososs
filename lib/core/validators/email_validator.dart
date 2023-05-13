
import 'base_validator.dart';

class EmailValidator extends BaseValidator {
  @override
  String getValidateMessage() {
    return "Invalid Email";
  }

  @override
  bool validateFunction(String value) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(value);
  }
}
class NumberValidator extends BaseValidator
{
  @override
  String getValidateMessage() {
    return "Invalid Number";
  }

  @override
  bool validateFunction(String value) {

    final regex = RegExp(
        r'^\d+$');
    return regex.hasMatch(value);
  }
}
