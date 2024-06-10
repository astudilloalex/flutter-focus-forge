import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showErrorSnackbar(BuildContext context, String errorCode) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SelectableText(messageFromCode(errorCode, context)),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showSuccessfulSnackbar(
  BuildContext context,
  String message, {
  int? milliseconds,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SelectableText(messageFromCode(message, context)),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: milliseconds ?? 4000),
    ),
  );
}

String messageFromCode(String code, BuildContext context) {
  final AppLocalizations localizations = AppLocalizations.of(context)!;
  final Map<String, String> errorMessages = {
    'wrong-password': localizations.wrongPassword,
    'invalid-name': localizations.invalidName,
  };
  return errorMessages[code] ?? code;
}

/// Generates a random alphanumeric code of a specified length.
///
/// The generated code consists of uppercase letters (A-Z), lowercase letters (a-z),
/// and digits (0-9). The default length of the code is 20 characters, but a different
/// length can be specified by providing an integer value as an argument.
String generateRandomCode([int length = 20]) {
  const List<String> chars = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'k',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  final StringBuffer sb = StringBuffer();
  final Random random = Random();

  for (int i = 0; i < length; i++) {
    sb.write(chars[random.nextInt(chars.length)]);
  }
  return sb.toString();
}
