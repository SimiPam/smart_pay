// ignore_for_file: prefer_adjacent_string_concatenation, unnecessary_string_escapes, duplicate_ignore

const String emptyEmailField = "Email field cannot be empty!";
const String emptyTextField = "Field cannot be empty!";
const String emptyPasswordField = "Password field cannot be empty";
const String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
const String passwordLengthError = "Password length must be greater than 8";
const String emptyUsernameField = "Username  cannot be empty";
const String usernameLengthError = "Username length must be greater than 6";
const String phoneNumberLengthError = "Phone number is invalid";
// ignore: prefer_interpolation_to_compose_strings, unnecessary_string_escapes
const String emailRegex = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
    "\\@" +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    ")+";
