import 'package:email_validator/email_validator.dart';

String checkRequired(String value) {
  if (value.isEmpty || value == null) {
    return "This field is required";
  }
  return null;
}

String validateFirstName(String value) {
  if (checkRequired(value) != null) {
    return checkRequired(value);
  } else if (value.length < 3) {
    return "First name must be atleast three characters long";
  }
  return null;
}

String validateLastName(String value) {
  if (checkRequired(value) != null) {
    return checkRequired(value);
  } else if (value.length < 3) {
    return "Last name must be atleast three characters long";
  }
  return null;
}

String validateMessage(String value, String fieldName, int minCharacterLimit) {
  //print(value);
  if (checkRequired(value) != null) {
    return checkRequired(value);
  } else if (value.length < minCharacterLimit) {
    return "$fieldName must be atleast $minCharacterLimit characters";
  }
  return null;
}

String validatePassword(String value) {
  if (checkRequired(value) != null) {
    return checkRequired(value);
  } else if (value.length < 8) {
    return 'The Password must be at least 8 characters.';
  }
  return null;
}

String validateEmail(String value) {
  if (checkRequired(value) != null) {
    return checkRequired(value);
  } else if (!EmailValidator.validate(value)) {
    return "The E-mail Address must be a valid email address";
  }
  return null;
}

String validatePhoneNumber(String value) {
  var inValidStr = "Phone number is Invalid";
  if (checkRequired(value) != null) {
    return checkRequired(value);
  } else if (value.trim().length < 7) {
    return inValidStr;
  } else if (value.startsWith("+") && value.trim().length < 11) {
    return inValidStr;
  } else if (value.startsWith("00") && value.trim().length < 12) {
    return inValidStr;
  } else if (value.startsWith("03") && value.trim().length < 11) {
    return inValidStr;
  } else if (value.trim().length < 7) {
    return inValidStr;
  }

  return null;
}

// bool isValidPhoneNumber(String string) {
//   // Null or empty string is invalid phone number
//   if (string == null || string.isEmpty) {
//     return false;
//   }

//   // You may need to change this pattern to fit your requirement.
//   // I just copied the pattern from here: https://regexr.com/3c53v
//   // const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
//   // final regExp = RegExp(pattern);

//   // if (!regExp.hasMatch(string)) {
//   //   return false;
//   // }
//   return true;
// }
